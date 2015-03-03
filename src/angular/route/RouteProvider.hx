
package angular.route;

@:injectionName("$routeProvider")
extern class RouteProvider {

    /**
     * Adds a new route definition to the $route service.
     *
     * @param path
     * @param route
     * @return
     */
	public function when(path : String, route : RouteProviderRoute) : RouteProvider;

	@:overload(function(path : String) : RouteProvider {})
    public function otherwise(route : RouteProviderRoute) : RouteProvider;
}


typedef RouteProviderRoute = {
	// controller – {(string|function()=} – Controller fn that should be associated with newly created
    // scope or the name of a registered controller if passed as a string.
    ?controller : Dynamic,
    // controllerAs – {string=} – An identifier name for a reference to the controller. If present, the controller
    // will be published to scope under the controllerAs name.
    ?controllerAs : String,
    // {string=|function()=}  – html template as a string or a function that returns an
    // html template as a string which should be used by ngView or ngInclude directives.
    // This property takes precedence over templateUrl.
    ?template : Dynamic,
    // templateUrl – {string=|function()=} – path or function that returns a path to an html template that should be used by ngView.
    ?templateUrl : Dynamic,
    // resolve - {Object.<string, function>=} - An optional map of dependencies which should be injected into the controller.
    ?resolve : Dynamic,
    // redirectTo – {(string|function())=} – value to update $location path with and trigger route redirection.
    ?redirectTo : Dynamic,
    // [reloadOnSearch=true] - {boolean=} - reload route when only $location.search() or $location.hash() changes.
    // If the option is set to false and url in the browser changes, then $routeUpdate event is broadcasted on the root scope.
    ?reloadOnSearch : Bool,
    // caseInsensitiveMatch=false] - {boolean=} - match routes without being case sensitive
    // If the option is set to true, then the particular route can be matched without being case sensitive
    ?caseInsensitiveMatch : Bool
}
