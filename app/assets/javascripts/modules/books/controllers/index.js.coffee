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
        return if $scope.editMode
        $location.path("books/#{$scope.books[idx].id}")

      $scope.editBook = (idx) ->
        $scope.books[idx].put().then ->
          _log "success!"

      $scope.manageUpload = (idx) ->
        $location.path("books/#{$scope.books[idx].id}/upload")

      $scope.addBook = ->
        Restangular.all('books').post($scope.book).then (data) ->
          $scope.books.push data
          $scope.book = {}
          $scope.bookForm = false

      $scope.cancel = ->
        $scope.book = {}
        $scope.bookForm = false


    ]
