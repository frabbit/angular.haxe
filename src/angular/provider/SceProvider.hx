
package angular.provider;

@:injectionName("$sceProvider")
extern class SceProvider {

	@:overload(function (value:Bool):Bool)
	public function enabled ():Bool;

}