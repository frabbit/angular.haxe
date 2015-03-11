
package angular.internal;

import haxe.macro.Expr;
import haxe.Constraints;

class DirectiveBuilderMacros {

	macro public function controller (ethis:Expr, f:ExprOf<Function>)
	{
		return angular.internal.DirectiveBuilderImpl.controller(ethis, f);
	}
	macro public function templateConstFile (ethis:Expr, f:String, ?suffix:Null<String> = ".html")
	{
		return angular.internal.DirectiveBuilderImpl.templateConstFile(ethis, f, suffix);
	}

}