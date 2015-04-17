angular.module("zoo_stops", ["ngMap"])
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
      .when "/map",
        templateUrl: "/assets/templates/stops/list.html"
        controller: "ZooStops.IndexCtrl"
  ]
