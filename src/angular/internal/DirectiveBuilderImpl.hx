package angular.internal;

import angular.internal.Support;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;

using haxe.macro.ExprTools;

class DirectiveBuilderImpl {

	public static function controller (ethis:Expr, f:ExprOf<Function>)
	{
		var args = Support.makeControllerArgs(f);
		return macro $ethis.controllerDynamic($args);
	}

	public static function templateConstFile (ethis:Expr, f:String, ?suffix = ".html")
	{
		return macro $ethis.templateConst(${angular.internal.FileMacros.getFileRelative(f+suffix)});
	}

}