
package angular.route;


@:injectionName("$route")
extern class Route {

    /**
     * Reference to the current route definition. The route definition contains:
     *   controller: The controller constructor as define in route definition.
     *   locals: A map of locals which is used by $controller service for controller
     *           instantiation. The locals contain the resolved values of the resolve
     *           map. Additionally the locals also contain:
     *              $scope - The current route scope.
     *              $template - The current route template HTML.
     */
    public var current: Dynamic;

    /**
     * Object with all route configuration Objects as its properties.
     */
    public var routes: Dynamic;

    /**
     * Causes $route service to reload the current route even if $location hasn't changed.
     * As a result of that, ngView creates new scope and reinstantiates the controller.
     */
    public function reload(): Void;

    /**
     * Causes $route service to update the current URL, replacing current route parameters
     * with those specified in newParams. Provided property names that match the route's
     * path segment definitions will be interpolated into the location's path, while
     * remaining properties will be treated as query params.
     * @param newParams Dynamic
     */
    public function updateParams(newParams: Dynamic) : Void;
}
