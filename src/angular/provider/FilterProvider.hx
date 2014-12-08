package angular.provider;

import haxe.Constraints.Function;

@:injectionName("$filterProvider")
extern class FilterProvider {

	// TODO macro
	public function register (name:String, f:Function):Void;

}