
package angular.provider;

@:injectionName("$httpProvider")
extern class HttpProvider {

	public var defaults : {
		xsrfCookieName : String,
		xsrfHeaderName : String,
		headers : {
			common : String,
			post : String,
			put : String,
			patch : String,
		}
	}

}