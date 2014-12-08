
package angular.service;

import angular.service.Http.HttpPromise;


@:injectionName("$templateRequest")
extern class TemplateRequest
{
	@:selfCall public function templateRequest (tpl: String, ?ignoreRequestError:Bool):HttpPromise;
}