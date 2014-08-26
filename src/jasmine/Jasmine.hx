
package jasmine;

typedef Expect<T> = {
	function toEqual (x:T):Void;
}

@:native("global") extern class Jasmine {


	public static function describe (name:String, f:Void->Void):Void;

	public static function it (name:String, f:Void->Void):Void;

	public static function expect <T>(what:T):Expect<T>;

	public static function beforeEach (f:Void->Void):Void;
	public static function afterEach (f:Void->Void):Void;

}