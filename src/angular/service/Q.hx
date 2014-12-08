
package angular.service;

@:injectionName("$q")
extern class Q {

	public function all<T>(arr : Array<Promise<T> >) : Promise<Array<T> >;

}