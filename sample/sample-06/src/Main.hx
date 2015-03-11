package ;

import angular.*;
import angular.service.*;

typedef Title = String;

typedef AppScope = {
	data : { title : String }
};

class Main
{

	static function formatTitle(t:Title):String {
		return "!!! " + t + " !!!";
	}

	static function main ()
	{
		var module =
			Angular.module("myModule", [])
			.factory( function ():Void->Title return function () return "angular.haxe")
			.factory( function () return formatTitle )
			.controller("AppController", function (s:TypedScope<AppScope>, getTitle:Void->Title, format:Title->String) {
				s.data = { title : format(getTitle()) };
			});
	}
}