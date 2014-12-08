
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

typedef HttpResponseObj = {
	data : Dynamic,
	status : Int,
	headers : String -> Null<String>,
	config : Dynamic,
	statusText : String
}

typedef HttpResponseString = {
	data : String,
	status : Int,
	headers : String -> Null<String>,
	config : Dynamic,
	statusText : String
}

typedef HttpSuccessObjFun = Dynamic -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;
typedef HttpErrorObjFun = Dynamic -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;

typedef HttpSuccessStringFun = ?String -> ?Int -> ?(String -> String) -> ?Dynamic -> ?String -> Dynamic;
typedef HttpErrorStringFun = String -> Int -> (String -> String) -> Dynamic -> String -> Dynamic;

extern class HttpPromise {

	@:overload(function<T> (success : HttpResponseString -> T, error : HttpResponseString -> T) : Promise<T> {})
	@:overload(function<T> (success : HttpResponseString -> T, error : HttpResponseObj -> T) : Promise<T> {})
	@:overload(function<T> (success : HttpResponseObj -> T, error : HttpResponseString -> T) : Promise<T> {})
	public function then<T>(success : HttpResponseObj -> T, ?error : HttpResponseObj -> T) : Promise<T>;


	@:overload(function (f : HttpSuccessStringFun) : HttpPromise {})
	public function success(f : HttpSuccessObjFun) : HttpPromise;

	@:overload(function (f : HttpSuccessStringFun) : HttpPromise {})
	public function error(f : HttpSuccessObjFun) : HttpPromise;
}