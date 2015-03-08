
package angular.internal;


import angular.internal.Support;
import haxe.ds.Option;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import haxe.macro.ExprTools;


class ModuleImpl {

	public static function provider (ethis:Expr, f:Expr, ?name:String):Expr
	{
		var cpos = Context.currentPos();

		var t = Context.typeof(f);

		var named = Support.getNamedArgs(f, t);

		var v = switch (Context.follow(t)) {
			case TFun(args, ret):
				var params = Support.convertArgsToParams(args, named, cpos);

				var getParams = switch (ret) {
					case TInst(_.get() => cl, _):

						var fields = cl.fields.get();
						var fields = fields.filter(function (c) return c.name == "get" && c.kind.match(FMethod(_)));
						if (fields.length == 0) {
							Context.error("the return type of f has no field get which is needed for a provider", cpos);
						} else {
							var f = fields[0];
							switch (f.type) {
								case TFun(args, ret):


									var paramsGet = Support.convertArgsToParams(args, named, cpos);
									var providerName = Support.fullQualified(cl.pack, cl.module, cl.name);
									var instanceName = Support.getIdForType(ret);

									if (name == null && providerName != instanceName + "Provider") {
										Context.error('$providerName should be ${instanceName + "Provider"}\nThe name of the provider class should be the instance name + the suffix "Provider"', cl.pos);
									}
									{ params : paramsGet, name : Support.getIdForType(ret) }
								case _ : Context.error("invalid field type for get", cpos);
							}
						}
					case TAnonymous(a) if (name == null): Context.error("anonymous providers are only supported if name is defined", cpos);
					case TAnonymous(a):

						var fields = a.get().fields;
						var fields = fields.filter(function (c) return c.name == "get");
						if (fields.length == 0) {
							Context.error("the return type of f has no field get which is needed for a provider", cpos);
						} else {
							var f = fields[0];

							switch (f.type) {
								case TFun(args, ret):
									var paramsGet = Support.convertArgsToParams(args, named, cpos);
									{ params : paramsGet, name : Support.getIdForType(ret) }
								case _ : Context.error("invalid field type for get", cpos);
							}
						}

					case _ : Context.error("not supported provider type", cpos);
				}
				{ params : params, paramsGet : getParams.params, name : getParams.name }
			case _ : Context.error("f must be a function returning a provider with a get function", cpos);

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
		var name = if (name != null) name else v.name;
		var res = macro $ethis.providerDynamic($v{name}, $args);
		return res;

	}

	public static function factory (ethis:Expr, f:ExprOf<Function>, ?as:Expr, ?name:String):Expr
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

		var t = Context.typeof(f);

		var named = Support.getNamedArgs(f, t);

		var v = switch (t) {
			case TFun(args, Support.isVoid(_) => true):
				Context.error("the return type of f should be a valid type, not Void", cpos);
			case TFun(args, ret):

				var injectArgs = Support.convertArgsToParams(args, named, cpos);

				var name = switch (castType) {
					case Some(x):
						try {
							var ct = haxe.macro.TypeTools.toComplexType(ret);
							var t = Context.typeof(macro ( (cast null : $ct) : $x));
							Support.getIdForType(t);
						} catch (x:Error) {
							//throw new Error(x, origExpr.pos);
							haxe.macro.Context.error(x.message, origExpr.pos);

						}
					case None: Support.getIdForType(ret);
				}

				{ injectArgs : injectArgs, name : name }
			default:
				Context.error("f must be a function returning a type", cpos);

		}

		var args = v.injectArgs.concat([f]);

		var name = if (name != null) name else v.name;
		return macro $ethis.factoryDynamic($v{name}, ( [$a{args}] : Array<Dynamic>) );
	}

	public static function directive (ethis:Expr, name:ExprOf<String>, f:ExprOf<Function>):Expr
	{
		var cpos = Context.currentPos();

		var t = Context.typeof(f);

		var named = Support.getNamedArgs(f, t);

		var injectArgs = switch (t) {
			case TFun(args, Support.isVoid(_) => true):
				Context.error("the return type of f should be a valid type, not Void", cpos);
			case TFun(args, ret):
				Support.convertArgsToParams(args, named, cpos);
			default:
				Context.error("f must be a function returning a type", cpos);
		}

		var args = injectArgs.concat([f]);

		return macro $ethis.directiveDynamic($name, ( [$a{args}] : Array<Dynamic>) );
	}

	public static function filter (ethis:Expr, name:ExprOf<String>, f:ExprOf<Function>):Expr
	{
		var cpos = Context.currentPos();

		var t = Context.typeof(f);

		var named = Support.getNamedArgs(f, t);

		var injectArgs = switch (t) {
			case TFun(args, TFun(_,Support.isVoid(_) => false)):
				Support.convertArgsToParams(args, named, cpos);
			case TFun(args, ret):
				Context.error("the return type of f should be a function which should not return Void", cpos);
			default:
				Context.error("f must be a function returning a function", cpos);
		}

		var args = injectArgs.concat([f]);

		return macro $ethis.filterDynamic($name, ( [$a{args}] : Array<Dynamic>) );
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