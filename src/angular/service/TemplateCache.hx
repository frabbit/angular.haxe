
package angular.service;


@:injectionName("$templateCache")
extern class TemplateCache
{
	public function put (name:String, template:String):Void;
}