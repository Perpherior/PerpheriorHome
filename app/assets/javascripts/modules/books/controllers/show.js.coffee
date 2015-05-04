angular.module('books')
  .controller 'Books.ShowCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    'Restangular'
    ($scope, $routeParams, $location, Restangular) ->
      Restangular.one('books', $routeParams.id).get().then (data) ->
        $scope.book = data

    ]
