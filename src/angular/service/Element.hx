
package angular.service;

import angular.service.Injector;
import js.JQuery;

@:injectionName("$element")

@:forward abstract Element(ElementData) from ElementData {

	@:from public static function fromJQuery (jq:js.JQuery):Element return cast jq;
	@:to public function toJQuery ():JQuery return cast this;

}

extern class ElementData extends js.JQuery {
	public function injector ():Injector;
}

