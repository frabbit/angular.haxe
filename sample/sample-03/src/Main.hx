package ;

import angular.*;
import angular.service.*;




typedef AppScope = { data : { firstName : String, lastName : String }};

class Main
{
	static function main ()
	{
		function appController (t:TypedScope<AppScope>) {
			t.data = {
				lastName : "tom",
				firstName : "timmy"
			};
		}
		var module =
			Angular.module("myModule", [])
			.controller("AppController", appController);


	}
}