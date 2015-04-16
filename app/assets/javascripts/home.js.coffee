angular
  .module("homeApp",["ngRoute", "templates", "restangular", "zoo_stops"])
  .config(["$locationProvider", ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])
  .controller "headerController",
    [
      "$scope", ($scope) ->
        $scope.name = "Perpherior"
    ]