angular.module("homeApp")
  .directive "maps", [ ->
    {
      restrict: "E"
      scope:
        customerInfo: "=ngModel"
      templateUrl: "assets/templates/map/map.html"
    }
  ]