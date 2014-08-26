angular.haxe
============

angular.haxe is a toolset for using angular.js in haxe applications. It tries to combine angular.js with the type safety of haxe as much as possible. The angular API is fully typed and haxe macros extend the api to support dependency injection based on types instead of unsafe strings.

It's currently incomplete, feel free to add pull requests or become a contributor.




Example of angular.haxe dependency injection
============================================

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
		// controller definition, the parameter types determine which dependencies needs to be injected.

		function appController (scope:Scope, config:Config) {
			trace("appController initialized");
			scope.set("data", { appName : config.appName });
		};

		// module definition

		var module =
			Angular.module("myModule", [])
			.factory(Config.new) // no need give the factory a name, the link is created by the types
			.controller(appController);
		}
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

see [Sample 2](sample/sample-02) for a slightly larger working example


