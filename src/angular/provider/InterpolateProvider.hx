
package angular.provider;

import angular.provider.InterpolateProvider;

@:injectionName("$interpolateProvider")
extern class InterpolateProvider {


	@:overload(function ():String {})
	public function startSymbol (value:String):InterpolateProvider;

	@:overload(function ():String {})
	public function endSymbol (value:String):InterpolateProvider;

}