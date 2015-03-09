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
			.factory( function ():Void->Title return function () return "angular.haxe")
			.factory( function ():Title->String return function (t:Title) return "!!! " + t + " !!!")
			.controller("AppController", function (s:TypedScope<AppScope>, getTitle:Void->Title, format:Title->String) {
				s.data = { title : format(getTitle()) };
			});
	}
}