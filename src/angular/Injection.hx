package angular;

import haxe.macro.Expr;
import haxe.Constraints.Function;

class Injection {
	macro public static function resolve (f : ExprOf<Function>):Expr {
		var args = angular.internal.Support.makeControllerArgs(f);
		return macro $args;
	}
}