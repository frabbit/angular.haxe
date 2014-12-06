
package angular.service;

// https://docs.angularjs.org/api/ng/service/$http
@:injectionName("$http")
extern class Http {

	public function get(url : String, ?config : Dynamic) : HttpPromise;
	public function head(url : String, ?config : Dynamic) : HttpPromise;

	public function post(url : String, data : Dynamic, ?config : Dynamic) : HttpPromise;
	public function put(url : String, data : Dynamic, ?config : Dynamic) : HttpPromise;

	public function delete(url : String, ?config : Dynamic) : HttpPromise;
	public function jsonp(url : String, ?config : Dynamic) : HttpPromise;

	public function patch(url : String, data : Dynamic, ?config : Dynamic) : HttpPromise;
}

/**
data – {string|Object} – The response body transformed with the transform functions.
status – {number} – HTTP status code of the response.
headers – {function([headerName])} – Header getter function.
config – {Object} – The configuration object that was used to generate the request.
statusText – {string} – HTTP status text of the response.
*/

typedef HttpSuccessObj = Dynamic -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;
typedef HttpErrorObj = Dynamic -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;

typedef HttpSuccessString = ?String -> ?Int -> ?(String -> String) -> ?Dynamic -> ?String -> Dynamic;
typedef HttpErrorString = String -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;

extern class HttpPromise {

	@:overload(function (success : HttpSuccessString, error : HttpErrorString) : Promise {})
	@:overload(function (success : HttpSuccessString, error : HttpErrorObj) : Promise {})
	@:overload(function (success : HttpSuccessObj, error : HttpErrorString) : Promise {})
	public function then(success : HttpSuccessObj, error : HttpErrorObj) : Promise;


	@:overload(function (f : HttpSuccessString) : HttpPromise {})
	public function success(f : HttpSuccessObj) : HttpPromise;

	@:overload(function (f : HttpSuccessString) : HttpPromise {})
	public function error(f : HttpSuccessObj) : HttpPromise;
}