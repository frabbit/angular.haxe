
package angular.provider;

@:injectionName("$locationProvider")
extern class LocationProvider {
	public function html5Mode(v:Bool):LocationProvider;
	public function hashPrefix(p:String):LocationProvider;
}
