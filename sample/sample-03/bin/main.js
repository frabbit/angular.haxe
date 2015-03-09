(function (console) { "use strict";
var Main = function() { };
Main.main = function() {
	var appController = function(t) {
		t.data = { lastName : "tom", firstName : "timmy"};
	};
	var module = window.angular.module("myModule",[]).controller("AppController",["$scope",appController]);
};
var angular__$Angular_TranscludeFn_$Impl_$ = {};
angular__$Angular_TranscludeFn_$Impl_$.call = function(this1,scope,link) {
	this1(scope,link);
};
angular__$Angular_TranscludeFn_$Impl_$.withoutScope = function(this1,link) {
	this1(link);
};
var angular_internal_ModuleMacros = function() { };
var angular_internal_InjectorMacros = function() { };
var q = window.jQuery;
var js = js || {}
js.JQuery = q;
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
