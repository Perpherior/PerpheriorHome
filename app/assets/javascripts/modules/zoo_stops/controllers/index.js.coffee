angular.module("zoo_stops")
  .controller "ZooStops.IndexCtrl", [
    "$scope"
    "$location"
    "Restangular"
    ($scope, $location, Restangular) ->
      Restangular.all('zoo_stops').getList().then (data) ->
        $scope.zoo_stops = data

      map = []

      $scope.$on 'mapInitialized', (event, evtMap) ->
        map = evtMap
        marker = map.markers[0]
    ]
