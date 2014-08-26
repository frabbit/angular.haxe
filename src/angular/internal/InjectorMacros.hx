package angular.internal;

import haxe.macro.Expr;

class InjectorMacros {
	macro public function get <T>(ethis:Expr, cl:Expr):ExprOf<T>
	{
		return angular.internal.InjectorImpl.get(ethis,cl);
	}
}