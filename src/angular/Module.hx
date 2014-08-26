package angular;


import haxe.macro.Expr;

#if !macro

import angular.Angular;

#end

import haxe.Constraints.Function;


extern class Module {

	// macros

	macro public function provider (ethis:Expr, f:ExprOf<Function>, ?name:String):Expr
	{
		return angular.internal.ModuleImpl.provider(ethis, f, name);
	}

	macro public function factory (ethis:Expr, f:ExprOf<Function>, ?as:Expr, ?name:String):Expr
	{
		return angular.internal.ModuleImpl.factory(ethis, f, as, name);
	}

	macro public function directive (ethis:Expr, name:String, f:ExprOf<Function>):Expr
	{
		return angular.internal.ModuleImpl.directive(ethis, name, f);
	}

	macro public function filter (ethis:Expr, name:String, f:ExprOf<Function>):Expr
	{
		return angular.internal.ModuleImpl.filter(ethis, name, f);
	}

	macro public function controller (ethis:Expr, name:String, f : ExprOf<Function>):Expr
	{
		return angular.internal.ModuleImpl.controller(ethis, name, f);
	}

	macro public function config (ethis:Expr, f : ExprOf<Function>):Expr
	{
		return angular.internal.ModuleImpl.config(ethis, f);
	}

	macro public inline function run (ethis:Expr, f:ExprOf<Function>):Expr
	{
		return angular.internal.ModuleImpl.run(ethis, f);
	}

	// dynamic api

	#if !macro

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

	#end
}