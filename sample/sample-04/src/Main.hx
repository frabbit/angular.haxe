
package ;

import angular.*;
import angular.support.*;
import angular.service.*;




typedef CustomString<Const> = String;

typedef AppScope = {
	data : { url : String, title : String, description : String }
};

class Main
{
	static function main ()
	{


		var module =
			Angular.module("myModule", [])
			.factory( function ():CustomString<"url"> return "https://github.com/frabbit/angular.haxe")
			.factory( function ():CustomString<"title"> return "angular.haxe")
			.factory( function ():CustomString<"desc"> return "Some words about angular.haxe...")


			.controller("AppController", function (s:TypedScope<AppScope>, url:CustomString<"url">, title : CustomString<"title">, desc:CustomString<"desc">) {

				s.data = { url : url, title : title, description : desc };
			});


	}
}