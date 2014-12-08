package angular.service;

@:injectionName("$interval")
extern class Interval {

	@:selfCall public function interval <T>(fn : Void->T, delay:Int, ?count:Int = 0, ?invokeApply:Bool = false):Promise<Dynamic>;

	public function cancel (p:Promise<Dynamic>):Bool;


}