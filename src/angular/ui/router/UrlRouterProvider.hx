package angular.ui.router;

// https://github.com/angular-ui/ui-router/wiki/URL-Routing

@:injectionName("$urlRouterProvider")
extern class UrlRouterProvider {

	@:overload(function (what : String, handler : Dynamic) : UrlRouterProvider {})
	public function when(what : String, handler : String) : UrlRouterProvider;


	@:overload(function (handler : Dynamic) : UrlRouterProvider {})
	public function otherwise(handler : String) : UrlRouterProvider;

	public function rule(handler : Dynamic) : UrlRouterProvider;

}