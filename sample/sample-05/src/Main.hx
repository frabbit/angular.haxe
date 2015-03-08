package ;

import angular.*;
import angular.service.*;

typedef Url = String;
typedef Title = String;
typedef Description = String;

typedef AppScope = {
	data : { url : String, title : String, description : String }
};

class Main
{
	static function main ()
	{
		var module =
			Angular.module("myModule", [])
			.factory( function ():Url return "https://github.com/frabbit/angular.haxe")
			.factory( function ():Title return "angular.haxe")
			.factory( function ():Description return "Some words about angular.haxe...")
			.controller("AppController", function (s:TypedScope<AppScope>, url:Url, title : Title, desc:Description) {
				s.data = { url : url, title : title, description : desc };
			});
	}
}