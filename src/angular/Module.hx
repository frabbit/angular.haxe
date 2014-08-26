package angular;

import angular.Angular;
import angular.internal.ModuleMacros;

extern class Module extends ModuleMacros
{
	// dynamic api

	@:noCompletion @:native("provider") public function providerDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("controller") public function controllerDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("factory") public function factoryDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("config") public function configDynamic (configFunc : Dynamic):Module;
	@:noCompletion @:native("service") public function serviceDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("directive") public function directiveDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("filter") public function filterDynamic (name:String, value:Dynamic):Module;
	@:noCompletion @:native("run") public function runDynamic (value:Dynamic):Module;

	// other api

	public var name(default, null):String;
	public var requires(default, null):Array<String>;
}