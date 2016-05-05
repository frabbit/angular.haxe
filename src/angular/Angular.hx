
package angular;



import angular.service.Element;
import angular.service.Injector;
import angular.service.Scope;
import haxe.Constraints.Function;

import js.html.Document;


import js.JQuery;

typedef DirectiveFunctionVoid = Void->Dynamic;
typedef DirectiveFunction = Function;

typedef ConfigFunction = Function;

typedef CloneLinkingFn = Scope->JQuery->Void;



abstract TranscludeFn(Dynamic) {

	public function call (scope:Scope, link:CloneLinkingFn)
	{
		this(scope, link);
	}

	public function withoutScope (link:CloneLinkingFn) {
		this(link);
	}
}

@:native("window.angular")
extern class Angular {

	@:overload(function (name:String, ?configFn:ConfigFunction):Module {})
	public static function module (name:String, requires:Array<String>, ?configFn:ConfigFunction):Module;

	public static function bootstrap (el:js.html.Element, ?modules:Array<String>):Module;

	@:overload(function (d:Document):Element {})
	public static function element (d:js.html.Element):Element;

	public static var version(default,null): { full : String, major : Int, minor : Int, dot : Int, codeName : String};

	public static function injector (?name:String, ?modules:Array<String>):Injector;

	public static function fromJson(str:String):Dynamic;

	public static function toJson(obj:Dynamic, ?pretty:Bool):String;

	public static function isDefined(value:Dynamic):Bool;
}
