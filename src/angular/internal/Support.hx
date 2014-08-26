
package angular.internal;

import haxe.macro.ComplexTypeTools;
import haxe.macro.TypeTools;
import haxe.macro.ExprTools;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;



class Support {

	public static function isVoid (t:Type)
	{
		return switch (t) {
			case TAbstract(_.get() => { pack : [], name : "Void"}, []):
				true;
			case _ :
				false;
		}
	}

	public static function getNamedArgs (f:Expr, t:Type)
	{
		return switch (t) {
			case TFun(args, ret):
				var args = [for (a in args) switch a.t {
					case TType(td,[TInst(_.get() => { kind : KExpr({ expr : EConst(CString(n))})} ,_),_]):
						{ arg : a.name, named : n };
					case _ :
						null;
				}];
				[for (a in args) if (a != null) a.arg => a];


			case _ : new Map();
		}
	}

	public static function convertArgsToParams (args:Array<{ name : String, opt : Bool, t : Type }>, named, cpos)
	{
		return [for (a in args) {
			var name = Support.getIdForType(a.t);
			var name = if (named.exists(a.name)) named.get(a.name).named else name;
			Context.makeExpr(name, cpos);
		}];
	}

	public static function makeControllerArgs (f:Expr):Expr
	{

		var cpos = Context.currentPos();

		var t = Context.typeof(f);

		var named = getNamedArgs(f, t);

		var params = switch (t) {
			case TFun(args, _):
				var params = convertArgsToParams(args, named, cpos);
				params;
			default:
				Context.error("f must be a function returning a type", cpos);
				[];
		}

		var args = params.concat([f]);
		return macro ( [$a{args}] : Array<Dynamic>);
	}

	public static function fullQualified(pack:Array<String>, module:String, typeName:String) {
		var pack = pack.join(".");
		var infix = if (pack.length > 0) "." else "";
		return pack + infix + typeName;
	}

	public static function getIdForType<T>(t:Type):String
	{

		function def (bt:BaseType)
		{
			var meta = bt.meta.get();
			var filter = meta.filter(function (e) return e.name == ":injectionName" && e.params.length == 1);
			return if (filter.length == 1) {
				switch (filter[0].params[0].expr) {
					case EConst(CString(s)): s;
					case _ : Context.error("Unsupported :injectionName format", filter[0].pos);
				}
			} else {
				var d = bt;
				fullQualified(d.pack, d.module, d.name);
			}
		}

		return switch (t) {
			case TInst(tt, p):
				def(tt.get());
			case TType(tt, p):
				def(tt.get());
			case TEnum(et,_):
				def(et.get());
			case TAbstract(at,_):
				def(at.get());
			case _ : throw "not supported type " + TypeTools.toString(t);
		}
	}


	/*
	public static function buildNamed ():Type
	{
		var myName = "foo";
		var className = "Named_" + myName + "_" + Context.signature(Context.currentPos());

		var pack = ["angular", "named"];

		Context.defineType({
			pack : pack,
			name : className,
			pos : Context.currentPos(),
			kind : TDClass(null,null,false),
			fields : []
		});
		return ComplexTypeTools.toType(TPath({pack: pack, name: className, params: []}));
	}
	*/

}