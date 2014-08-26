
package angular.service;

@:injectionName("$interpolate")
// text -> mustHaveExpression -> trustedContext -> allOrNothing -> interpolation function
typedef Interpolate = String->?Bool->?String->?Bool->({}->String)