
package angular.service;

@:injectionName("$sce")
extern class StrictContextualEscaping {

	public function isEnabled():Bool;

	public function parseAs(type:String, expression:String):{}->{}->Dynamic;
	public function parseAsHtml(expression:String):{}->{}->Dynamic;
	public function parseAsCss(expression:String):{}->{}->Dynamic;
	public function parseAsUrl(expression:String):{}->{}->Dynamic;
	public function parseAsResourceUrl(expression:String):{}->{}->Dynamic;
	public function parseAsJs(expression:String):{}->{}->Dynamic;

	public function trustAs<T>(type:String, value:T):T;
	public function trustAsHtml<T>(value:T):T;
	public function trustAsUrl<T>(value:T):T;
	public function trustAsResourceUrl<T>(value:T):T;
	public function trustAsJs<T>(value:T):T;

	public function getTrusted<T>(type:String, value:T):T;
	public function getTrustedHtml<T>(value:T):T;
	public function getTrustedCss<T>(value:T):T;
	public function getTrustedUrl<T>(value:T):T;
	public function getTrustedResourceUrl<T>(value:T):T;
	public function getTrustedJs<T>(value:T):T;
}