package angular.service;


import haxe.macro.Expr;


@:injectionName("$injector")
extern class Injector {

	macro public function get <T>(ethis:Expr, cl:Expr):ExprOf<T>
	{
		return angular.internal.InjectorImpl.get(ethis,cl);
	}

	#if !macro

	@:native("get") public function getDynamic (id:String):Dynamic;

	public inline function getById <T>(id:String, cl:Class<T>):T {
		return getDynamic(id);
	}

	#end


}