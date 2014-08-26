
package protractor;

import angular.service.Element;
import webdriver.Locator;

extern class ElementArrayFinder {

}

extern class ElementFinder {

}

extern class Browser {
	public function getTitle():String;
	public function get(url:String):Void;
}

extern class By {
	public function css (s:String):Locator;
	public function model (s:String):Locator;
	public function repeater (s:String):Locator;
	public function binding (s:String):Locator;
}

extern class ElementStatic {
	public function all (selector:String):ElementArrayFinder;
}

@:native("global")
extern class Protractor {

	public function isElementPresent (e:Locator):Bool;

	public static function getInstance():Protractor;

	public static var element:ElementStatic;
	@:native("element") public static function elementOne (locator:Locator):ElementFinder;
	public static var by : By;
	public static var browser : Browser;



}