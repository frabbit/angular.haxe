
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

	public static function convertArgsToParams (args:Array<{ name : String, opt : Bool, t : Type }>, cpos)
	{
		return [for (a in args) {
			var name = Support.getIdForType(a.t);
			Context.makeExpr(name, cpos);
		}];
	}

	public static function makeControllerArgs (f:Expr):Expr
	{

		var cpos = Context.currentPos();

		var t = Context.typeof(f);

		var params = switch (t) {
			case TFun(args, _):
				var params = convertArgsToParams(args, cpos);
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

		function def (bt:BaseType, t:Type, params)
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
				TypeTools.toString(t);
			}
		}

		return switch (t) {
			case TInst(tt, p):
				def(tt.get(), t, p);
			case TType(tt, p):
				def(tt.get(), t, p);
			case TFun(_,_), TAnonymous(_):
				TypeTools.toString(t);
			case TLazy(f):
				getIdForType(f());
			case TEnum(et,p):
				def(et.get(), t, p);
			case TAbstract(at,p):
				def(at.get(), t, p);
			case _ : throw "not supported type " + TypeTools.toString(t);
		}
	}

}