
package angular.service;

@:injectionName("$location")
extern class Location {

	@:overload(function ():String {})
	public function path (p:String):Void;

	public function replace ():Void;
	public function url ():String;

}