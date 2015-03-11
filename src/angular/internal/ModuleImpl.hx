
package angular.internal;


import angular.internal.Support;
import haxe.ds.Option;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import haxe.macro.ExprTools;


class ModuleImpl {

	public static function provider (ethis:Expr, f:Expr):Expr
	{
		var cpos = Context.currentPos();

		var t = typeofNormalized(f);


		var v = switch (Context.follow(t)) {
			case TFun(args, ret):
				var params = Support.convertArgsToParams(args, cpos);

				var getParams = switch (ret) {
					case TInst(_.get() => cl, _):

						var fields = cl.fields.get();
						var fields = fields.filter(function (c) return c.name == "get" && c.kind.match(FMethod(_)));
						if (fields.length == 0) {
							err("the return type of f has no field get which is needed for a provider", cpos);
						} else {
							var f = fields[0];
							switch (f.type) {
								case TFun(args, ret):


									var paramsGet = Support.convertArgsToParams(args, cpos);
									var providerName = Support.fullQualified(cl.pack, cl.module, cl.name);
									var instanceName = Support.getIdForType(ret);

									if (providerName != instanceName + "Provider") {
										err('$providerName should be ${instanceName + "Provider"}\nThe name of the provider class should be the instance name + the suffix "Provider"', cl.pos);
									}
									{ params : paramsGet, name : Support.getIdForType(ret) }
								case _ : err("invalid field type for get", cpos);
							}
						}
					case _ : err("not supported provider type", cpos);
				}
				{ params : params, paramsGet : getParams.params, name : getParams.name }
			case _ : err("f must be a function returning a provider with a get function", cpos);

		}

		var args1 = [for (i in 0...v.paramsGet.length) macro $i{"arg"+i}];
		var innerCall = macro function () {
			return res.get($a{args1});
		}
		switch (innerCall.expr) {
			case EFunction(name, f):
				var args = [for (i in 0...v.paramsGet.length) { name : "arg"+i, type : null, opt : false, value : null}];
				var f = {
					args : args,
					ret : null,
					expr : f.expr
				}
				innerCall.expr = EFunction(name, f);
			case _ : throw "assert";
		}
		var args1 = [for (i in 0...v.params.length) macro $i{"argWrapper"+i}];

		var args2 = macro ( [$a{v.paramsGet.concat([innerCall])}] : Array<Dynamic>);

		var wrapperCall = macro function () {
			var res = $f($a{args1});

			if (!Reflect.hasField(res, "$get")) {
				Reflect.setField(res, "$get", $args2);
			}
			return res;
		}
		switch (wrapperCall.expr) {
			case EFunction(name, f):
				var args = [for (i in 0...v.params.length) { name : "argWrapper"+i, type : null, opt : false, value : null}];
				var f = {
					args : args,
					ret : null,
					expr : f.expr
				}
				wrapperCall.expr = EFunction(name, f);
			case _ : throw "assert";
		}
		// inject the $get name into the type
		var args = macro ( [$a{v.params.concat([wrapperCall])}] : Array<Dynamic>);
		var res = macro $ethis.providerDynamic($v{v.name}, $args);
		return res;

	}

	public static function bundle(ethis:Expr, b:ExprOf<{}>):Expr
	{
		var r = switch (b.expr)
		{
			case EParenthesis( { expr : ECheckType(macro _, ct) }):
				var expr = macro @:pos(b.pos) ( null : $ct );
				{ ct: ct, expr : expr };
			case _ : err("expression must be a CheckType expression like factoryBundle(( _ : MyType ))", b.pos);
		}
		var ct = r.ct;
		var typeExpr = r.expr;
		var t = typeofNormalized(typeExpr);

		return switch Context.follow(t)
		{
			case TAnonymous(a):
				var afields = a.get().fields;

				var funArgs = [for (f in afields) { name : f.name, type : TypeTools.toComplexType(f.type) }];
				var objFields = [for (f in afields) { field : f.name, expr : macro @:pos(b.pos) $i{f.name} }];

				var res = { expr : EObjectDecl(objFields), pos : b.pos }

				var f = EFunction(null, {
					args : funArgs,
					ret : ct,
					expr : macro return $res
				});
				var fexpr = { expr : f, pos : b.pos };
				factory(ethis, fexpr);
			case _ :
				err("error type of argument is not a structure aliases by a typedef", b.pos);
		}

	}

	static function err <T>(msg:String, pos):T {
		return Context.error("the return type of f should be a valid type, not Void", pos);
		//return throw "assert";
	}

	public static function factory (ethis:Expr, f:ExprOf<Function>):Expr
	{
		var cpos = Context.currentPos();

		var origExpr = f;
		var castType = switch (f.expr) {
			case EParenthesis({expr:ECheckType(a,t)}):

				f = a;
				Some(t);
			case _ :
				None;
		}

		var t = typeofNormalized(f);

		var v = switch (t) {
			case TFun(args, Support.isVoid(_) => true):
				err("the return type of f should be a valid type, not Void", cpos);
			case TFun(args, ret):

				var injectArgs = Support.convertArgsToParams(args, cpos);

				var name = switch (castType) {
					case Some(x):
						try {
							var ct = haxe.macro.TypeTools.toComplexType(ret);
							var t = Context.typeof(macro ( (cast null : $ct) : $x));
							Support.getIdForType(t);
						} catch (x:Error) {
							err(x.message, origExpr.pos);
						}
					case None: Support.getIdForType(ret);
				}

				{ injectArgs : injectArgs, name : name }
			default:
				err("f must be a function returning a type", cpos);

		}

		var args = v.injectArgs.concat([f]);

		return macro $ethis.factoryDynamic($v{v.name}, ( [$a{args}] : Array<Dynamic>) );
	}

	public static function directive (ethis:Expr, name:ExprOf<String>, f:ExprOf<Function>):Expr
	{
		var cpos = Context.currentPos();

		var t = typeofNormalized(f);

		var injectArgs = switch (t) {
			case TFun(args, Support.isVoid(_) => true):
				err("the return type of f should be a valid type, not Void", cpos);
			case TFun(args, ret):
				Support.convertArgsToParams(args, cpos);
			default:
				err("f must be a function returning a type", cpos);
		}

		var args = injectArgs.concat([f]);

		return macro $ethis.directiveDynamic($name, ( [$a{args}] : Array<Dynamic>) );
	}

	public static function filter (ethis:Expr, name:ExprOf<String>, f:ExprOf<Function>):Expr
	{
		var cpos = Context.currentPos();

		var t = typeofNormalized(f);

		var injectArgs = switch (t) {
			case TFun(args, TFun(_,Support.isVoid(_) => false)):
				Support.convertArgsToParams(args, cpos);
			case TFun(args, ret):
				err("the return type of f should be a function which should not return Void", cpos);
			default:
				err("f must be a function returning a function", cpos);
		}

		var args = injectArgs.concat([f]);

		return macro $ethis.filterDynamic($name, ( [$a{args}] : Array<Dynamic>) );
	}

	static function typeofNormalized (f:Expr) {
		return Support.typeofNormalized(f);
	}

	public static function controller (ethis:Expr, name:ExprOf<String>, f : ExprOf<Function>):Expr
	{
		var args = Support.makeControllerArgs(f);
		return macro $ethis.controllerDynamic($name, $args );
	}

	public static function config (ethis:Expr, f : ExprOf<Function>):Expr
	{
		var args = Support.makeControllerArgs(f);
		return macro $ethis.configDynamic( $args );
	}

	public static function run (ethis:Expr, f:ExprOf<Function>):Expr
	{
		var args = Support.makeControllerArgs(f);
		return macro $ethis.runDynamic($args);
	}

}