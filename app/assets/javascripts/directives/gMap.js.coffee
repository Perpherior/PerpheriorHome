angular.module("homeApp")
  .directive "maps", [ "Restangular", (Restangular) ->
    restrict: "E"
    scope: 
      stopPromise: "="
      name: "="
    templateUrl: "assets/templates/map/map.html"
    link: (scope, element, attr) ->
      scope.stopPromise.getList().then (data) ->
        _log data
      # scope.stops.$promise.then (data) ->
      #   _log data
      # _log scope
      # scope.zoo_stops = JSON.parse attr.stops
      # map = []
      # scope.$on 'mapInitialized', (event, evtMap) ->
      #   map = evtMap
      #   marker = map.markers[0]

  ]