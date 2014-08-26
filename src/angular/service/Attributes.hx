
package angular.service;

@:injectionName("$attributes")
extern class Attributes {


	public inline function has (field:String):Bool {
		return Reflect.hasField(this, field);
	}
	public inline function get (field:String):Dynamic {
		return Reflect.field(this, field);
	}
}