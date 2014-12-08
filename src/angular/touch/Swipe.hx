
package angular.touch;

import angular.service.Element;

private typedef Point = { x : Float, y : Float };

typedef SwipeHandlers = {
	start : Point -> Void,
	end : Point -> Void,
	move : Point -> Void,
	cancel : Void -> Void,
}

@:injectionName("$swipe")
extern class Swipe {
	public function bind (el:Element, options:SwipeHandlers, ?types : Array<String>):Void;

}