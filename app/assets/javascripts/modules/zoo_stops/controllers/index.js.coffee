angular.module("zoo_stops")
  .controller "ZooStops.IndexCtrl", [
    "$scope"
    "$location"
    "Restangular"
    ($scope, $location, Restangular) ->
      $scope.greet = "nihao"

      $scope.z_stop = Restangular.all('zoo_stops').getList()
      $scope.stop_promise = Restangular.all('zoo_stops')

      Restangular.all('zoo_stops').getList().then (data) ->
        $scope.zoo_stops = data
        $scope.zoo_stop = data[0]

    ]
