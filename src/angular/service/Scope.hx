package angular.service;

import haxe.Constraints;

private typedef UnregisterFn = Void->Void;

typedef ScopeEvent = {
	targetScope : Scope,
	currentScope : Scope,
	name : String,
	stopPropagation : Void->Void, // ?? not sure
	preventDefault : Void->Void, // ?? not sure
	defaultPrevented : Bool
}

@:injectionName("$scope")
extern class Scope
{
	@:overload(function ():Void {}) // ?? not sure
	@:overload(function (f:Void->Void):Void {})
	@:overload(function (expr:String):Dynamic {})
	@:native("$eval") public function eval<T>(f:Scope->T):T;

	@:overload(function ():Void {}) // ?? not sure
	@:overload(function (f:Void->Void):Void {})
	@:overload(function (expr:String):Void {})
	@:native("$evalAsync") public function evalAsync<T>(f:Scope->T):Void;

	@:native("$parent")public var parent:Scope;

	@:native("$destroy") public function destroy():Void;

	@:native("$digest") public function digest():Void;

	@:native("$new") public function mkNew(isolate:Bool):Scope;

	@:overload(function (e:ScopeEvent->Void):UnregisterFn {})
	@:native("$on") public function on(name:String, listener:Function):UnregisterFn;

	@:native("$emit") public function emit(name:String, ?data:Dynamic):Void;

	@:native("$broadcast") public function broadcast(name:String, ?data:Dynamic):Void;

	@:overload(function <T>(expr:String, listener:T->T->Void, ?objectEquality:Bool = false):UnregisterFn {})
	@:native("$watch") public function watch<T>(expr:String, listener:T->T->Scope->Void, ?objectEquality:Bool = false):UnregisterFn;

	@:native("$watchGroup") public function watchGroup<T>(expr:Array<String>, listener:Array<T>->Array<T>->?Scope->Void):UnregisterFn;

	@:native("$watchCollection") public function watchCollection<T>(expr:String, listener:Array<T>->Array<T>->?Scope->Void):UnregisterFn;

	@:overload(function (f:Scope->Void):Void {})
	@:overload(function (f:Void->Void):Void {})
	@:native("$apply") public function apply(expr:String):Void;

	@:overload(function (f:Scope->Void):Void {})
	@:overload(function (f:Void->Void):Void {})
	@:native("$applyAsync") public function applyAsync(expr:String):Void;

	@:native("$root") public var root:Scope;

	@:native("$$phase") public var phase:String;

	public inline function onDestroy(listener:Void->Void):UnregisterFn
	{
		return on("$destroy", listener);
	}

	public inline function get (field:String):Dynamic
	{
		return Reflect.field(this, field);
	}

	public inline function set (field:String, val:Dynamic):Scope
	{
		Reflect.setField(this, field, val);
    return this;
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
