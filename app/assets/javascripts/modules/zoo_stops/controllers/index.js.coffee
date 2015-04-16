angular.module("zoo_stops")
  .controller "ZooStops.IndexCtrl", [
    "$scope"
    "$location"
    "Restangular"
    ($scope, $location, Restangular) ->
      $scope.hi = "hi"
    ]
