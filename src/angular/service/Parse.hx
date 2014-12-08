package angular.service;

@:injectionName("$parse")
extern class Parse {
	@:selfCall public function parse(expression : String) : Dynamic;
}