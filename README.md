angular.haxe
============

angular.haxe is a toolset for using angular.js in haxe applications. It tries to combine angular.js with the type safety of haxe as much as possible. The angular API is fully typed and haxe macros extend the api to support dependency injection based on types instead of unsafe strings.

It's currently incomplete, feel free to add pull requests or become a contributor.




# Example of angular.haxe dependency injection

```haxe
// a regular haxe model
class Config {
	public var appName = "News App";
	public function new () {}
}

class Main
{
	static function main ()
	{
		// controller definition, the parameter types determine
		// which dependencies needs to be injected.

		function appController (scope:Scope, config:Config) {
			trace("appController initialized");
			scope.set("data", { appName : config.appName });
		};

		// module definition

		var module =
			Angular.module("myModule", [])
			// no need give the factory a name,
			// the link is created by the types
			.factory(Config.new)
			.controller(appController);
	}
}
```
```html
<html>
<head>
	<title>Angular-Haxe</title>
</head>
<body ng-app="myModule" ng-controller="AppController">
	<h1>{{data.appName}}</h1>
</body>
</html>
```

See [Sample 2](sample/sample-02) for a slightly larger working example. The generating js file for this example can be found [here](sample/sample-02/bin/main.js).

# angular.haxe vs angular.js

here are same snippets which highlight differences of angular.haxe vs pure angular.js

# factory / service registration

```js

function MyService (timeout, location) {
	// do something with timeout and location
}

// register as factory
angular.module("myModule", [])
	.factory("myConfig", ["$timeout", "$location", function (timeout, location) {
		return new Config(timeout, location);
	}])

```
In angular.haxe dependency injection in general is based on the type to achieve more type safety. This type gets translated into a string at compile time, e.g. my.pack.MyService becomes "my.pack.MyService". This translation is done through macros which run at compile time and convert the abstract syntax tree in such a way that the generated code is very similar to the js code.

```haxe
class MyService {
	public function new (timeout:Timeout, location:Location) {
		// do something with timeout and location
	}
}

// register as factory
Angular.module("myModule", [])
	.factory(MyService.new);
```
This generated js code looks similar to the next snippet.
```js

function MyService { .... }

Angular.module("myModule", [])
	.factory("MyService", ["$timeout", "$location", function (a1, a2) {
		return new MyService(a1,a2)
	}]);
```




