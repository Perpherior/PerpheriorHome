angular.module('books')
  .controller 'Books.IndexCtrl', [
    '$scope'
    '$location'
    'Restangular'
    ($scope, $location, Restangular) ->
      $scope.greet = 'nihao'

      Restangular.all('books').getList().then (data) ->
        $scope.books = data

      $scope.show = (idx) ->
        _log $scope.books[idx]

      $scope.sortableOptions = {
        'ui-floating': true
      }

    ]