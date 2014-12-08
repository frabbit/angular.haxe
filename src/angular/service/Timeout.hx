
package angular.service;



@:injectionName("$timeout")
extern class Timeout {

	@:selfCall public function timeout <T>(fn:Void->T, ?delay:Int, ?invokeApply:Bool):Promise<T>;

	public function cancel (p:Promise<Dynamic>):Bool;
}