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

      showPath = (book) ->
        baseUrl = "books/#{book.id}"
        url = if book.has_bookmark then baseUrl + "/chapters/#{book.bookmark_chapter_id}" else baseUrl

      $scope.show = (idx) ->
        return if $scope.editMode
        $location.path(showPath($scope.books[idx]))

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
