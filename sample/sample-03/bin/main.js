(function (console) { "use strict";
var Main = function() { };
Main.main = function() {
	var appController = function(t,s) {
		t.data = { lastName : "tom", firstName : "timmy"};
	};
	var module = window.angular.module("myModule",[]).controller("AppController",["$scope","$scope",appController]);
};
var angular = {};
angular._Angular = {};
angular._Angular.TranscludeFn_Impl_ = {};
angular._Angular.TranscludeFn_Impl_.call = function(this1,scope,link) {
	this1(scope,link);
};
angular._Angular.TranscludeFn_Impl_.withoutScope = function(this1,link) {
	this1(link);
};
angular.internal = {};
angular.internal.ModuleMacros = function() { };
angular.internal.InjectorMacros = function() { };
var js = {};
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
