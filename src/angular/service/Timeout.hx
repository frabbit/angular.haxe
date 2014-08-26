
package angular.service;



@:injectionName("$timeout")
@:callable abstract Timeout((Void->Void)->?Int->?Bool->Promise) {

	public function cancel (promise:Promise):Bool {
		return (this:Dynamic).cancel(promise);
	}
}