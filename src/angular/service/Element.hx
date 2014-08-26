
package angular.service;

import angular.service.Injector;

@:injectionName("$element")
extern class Element extends js.JQuery {
	public function injector ():Injector;
}