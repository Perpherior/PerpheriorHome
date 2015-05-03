angular.module('books')
  .controller 'Books.IndexCtrl', [
    '$scope'
    '$location'
    'Restangular'
    ($scope, $location, Restangular) ->
      $scope.bookForm = false
      $scope.editMode = false

      Restangular.all('books').getList().then (data) ->
        $scope.books = data

      $scope.show = (idx) ->
        _log $scope.books[idx]

      $scope.addBook = ->
        Restangular.all('books').post($scope.book).then (data) ->
          $scope.books.push data
          $scope.book = {}
          $scope.bookForm = false

    ]
