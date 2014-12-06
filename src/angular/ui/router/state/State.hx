package angular.ui.router.state;

// http://angular-ui.github.io/ui-router/site/#/api/ui.router.state.$state

@:injectionName("$state")
extern class State {

	public var params : Dynamic;
	public var current : Dynamic;
	public var transition : Promise<Dynamic>;

	// Returns the state configuration object for any specific state or all states.
	@:overload(function (?name : Dynamic, ?context : Dynamic) : Array<Dynamic> {})
	@:overload(function (?name : Dynamic, ?context : Dynamic) : Dynamic {})
	@:overload(function (?name : Dynamic, ?context : String) : Array<Dynamic> {})
	@:overload(function (?name : Dynamic, ?context : String) : Dynamic {})
	@:overload(function (?name : String, ?context : Dynamic) : Array<Dynamic> {})
	@:overload(function (?name : String, ?context : Dynamic) : Dynamic {})
	@:overload(function (?name : String, ?context : String) : Array<Dynamic> {})
	public function get(?name : String, ?context : String) : Dynamic;

	public function go(to : String, ?params : Dynamic, ?options : Dynamic) : angular.Promise<Dynamic>;

	@:overload(function (state : Dynamic, ?params : Dynamic, ?options : Dynamic) : String {})
	public function href(name : String, ?params : Dynamic, ?options : Dynamic) : String;

	@:overload(function (state : Dynamic, ?params : Dynamic, ?options : Dynamic) : Bool {})
	public function includes(name : String, ?params : Dynamic, ?options : Dynamic) : Bool;

	@:overload(function (state : Dynamic, ?params : Dynamic, ?options : Dynamic) : Bool {})
	public function is(name : String, ?params : Dynamic, ?options : Dynamic) : Bool;

	public function reload() : angular.Promise<Dynamic>;

	public function transitionTo(to : String, toParams : Dynamic, options : Dynamic) : angular.Promise<Dynamic>;

}