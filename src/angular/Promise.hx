
package angular;

extern class Promise<T> {
	@:native("then")
	public function thenFlat<U>(f : T -> Promise<U>) : Promise<U>;

	public function then<U>(f : T -> U) : Promise<U>;
}
