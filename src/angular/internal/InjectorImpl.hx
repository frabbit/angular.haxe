package angular.internal;

import angular.internal.Support;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.ExprTools;
import haxe.macro.TypeTools;

class InjectorImpl {

	public static function get <T>(ethis:Expr, cl:Expr):ExprOf<T>
	{
		var ang = macro angular.Angular;

		var cStr = ExprTools.toString(cl);

		var t = Context.typeof(Context.parse("{ var x : " + cStr + "; x;}", cl.pos));

		var id = Support.getIdForType(t);
		var ct = TypeTools.toComplexType(t);
		return macro ($ethis.getDynamic($v{id}) : $ct);
	}

}