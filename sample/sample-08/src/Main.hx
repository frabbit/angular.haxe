package ;

import angular.*;
import angular.service.*;

typedef Bundle = {
	x : String,
	y : Int
};

typedef AppScope = {
	data : { title : String }
};

class Main
{
	static function main ()
	{
		var module =
			Angular.module("myModule", [])
			.factory( function () return 5)
			.factory( function () return "times")
			.bundle( ( _ : Bundle ) )
			.controller("AppController", function (s:TypedScope<AppScope>, bundle:Bundle) {
				s.data = { title : bundle.y + " " + bundle.x };
			});
	}
}