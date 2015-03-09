package ;

import angular.*;
import angular.service.*;

typedef Title = String;

typedef AppScope = {
	data : { title : String }
};

class Main
{
	static function main ()
	{
		var module =
			Angular.module("myModule", [])
			.factory( function ():{ t : Title } return { t :"angular.haxe" })
			.controller("AppController", function (s:TypedScope<AppScope>, options:{ t : Title }) {
				s.data = { title : options.t };
			});
	}
}