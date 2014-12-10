
package angular.service;

extern class Deferred<T> {
	public var promise : Promise<T>;
}

@:injectionName("$q")
extern class Q {

	public function all<T>(arr : Array<Promise<T> >) : Promise<Array<T> >;

	@:selfCall
	public function create<T, U>(resolve : T -> Void, reject : U -> Void) : Promise<T>;

	public function reject<T, U>(reason : U) : Promise<T>;

	public function defer<T>() : Deferred<T>;

	@:overload(function<T>(v : T) : Promise<T> {})
	public function when<T>(promise : Promise<T>) : Promise<T>;

}