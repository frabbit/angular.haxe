
package angular.service;

import angular.service.Element;
import angular.Angular;


@:injectionName("$compile")
typedef Compile = String -> (Scope->?CloneLinkingFn->Element);