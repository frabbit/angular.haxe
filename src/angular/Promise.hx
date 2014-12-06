
package angular;

extern class Promise<T> {
	public function then<U>(f : T -> U) : Promise<U>;
}
