package angular.service;

import haxe.Constraints;

private typedef UnregisterFn = Void->Void;

@:injectionName("$scope")
extern class Scope
{

	@:overload(function (expr:String):Dynamic {})
	@:native("$eval") public function eval(f:Function):Dynamic;

	@:native("$parent")public function parent():Scope;

	@:native("$destroy") public function destroy():Void;

	@:native("$digest") public function digest():Void;

	@:native("$new") public function mkNew(isolate:Bool):Scope;


	@:native("$on") public function on(name:String, listener:Function):UnregisterFn;

	@:native("$emit") public function emit(name:String, ?data:Dynamic):Void;

	@:native("$broadcast") public function broadcast(name:String, ?data:Dynamic):Void;

	@:native("$watch") public function watch(expr:String, listener:Function, ?objectEquality:Bool = false):UnregisterFn;
	
	@:native("$watchGroup") public function watchGroup(expr:Array<String>, listener:Function, ?objectEquality:Bool = false):UnregisterFn;

	@:overload(function (f:Void->Void):Void {})
	@:native("$apply") public function apply(?expr:String):Void;

	@:native("$root") public var root:Scope;

	@:native("$$phase") public var phase:String;

	public inline function onDestroy(listener:Function):UnregisterFn
	{
		return on("$destroy", listener);
	}

	public inline function get (field:String):Dynamic
	{
		return Reflect.field(this, field);
	}

	public inline function set (field:String, val:Dynamic):Void
	{
		Reflect.setField(this, field, val);
	}

	public inline function safeApply(f:Void->Void):Void
	{
		var phase = this.root.phase;

		if(phase == "$apply" || phase == "$digest") {
			eval(f);
		} else {
			this.apply(f);
		}
	}

}