
package ;

import angular.*;
import angular.support.*;
import angular.service.*;

typedef Entry = {
	text : String,
	img : String
}

class News {
	public var entries:Array<Entry>;

	public function new (c:Config) {
		var base = "http://" + c.host + c.imagePath;
		this.entries = [
			{
				text : "Wonderful new car invented",
				img : base + "car.jpg"
			},
			{
				text : "Evolution finally happened",
				img : base + "evolution.jpg"
			}
		];
	}
	public function add (text, img)
	{
		entries.push({ text : text, img : img});
	}

	public function clear ()
	{
		entries.splice(0, entries.length);

	}
}

class Locale {
	var lang = "de";
	public function new () {}
	public function localize (x:String) {
		return lang + ": " + x;
	}
}

class Config {
	public var appName = "News App";
	public var imagePath = "/img/";
	public var host = "localhost";
	public function new () {}
}


class Main
{
	static function main ()
	{

		var newsController = function (scope:Scope, news:News) {
			var newEntry = { text : "", img : "" };
			scope.set("newEntry", newEntry);
			scope.set("entries", news.entries);
			scope.set("clickEntry", function (e:Entry) {
				trace("entry clicked: " + e.text);
			});

			scope.set("addNews", function () {
				news.add(newEntry.text, newEntry.img);
				newEntry.text = "";
				newEntry.img = "";
			});

			scope.set("clear", news.clear);
		}

		var newsDirective = DirectiveBuilder.mk()
			.templateConstFile("NewsTemplate")
			.controller(newsController).build;

		var appController = function (scope:Scope, config:Config) {
			trace("appController initialized");
			scope.set("data", { appName : config.appName });
		};

		var module =
			Angular.module("myModule", [])
			.factory(News.new)
			.factory(Config.new)
			.factory(Locale.new)
			.filter("localize", function (l:Locale) {
				return function (x) {
					return l.localize(x);
				}
			})
			.directive("news", newsDirective)
			.controller("AppController", appController);


	}
}