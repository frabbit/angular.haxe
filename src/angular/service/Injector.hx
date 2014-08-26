package angular.service;

import angular.internal.InjectorMacros;

@:injectionName("$injector")
extern class Injector extends InjectorMacros {

	@:native("get") public function getDynamic (id:String):Dynamic;

	public inline function getById <T>(id:String, cl:Class<T>):T {
		return getDynamic(id);
	}
}