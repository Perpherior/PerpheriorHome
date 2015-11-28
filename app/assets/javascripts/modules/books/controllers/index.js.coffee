angular.module('books')
  .controller 'Books.IndexCtrl', [
    '$scope'
    '$location'
    'Restangular'
    '$filter'
    ($scope, $location, Restangular, $filter) ->
      $scope.editMode = false
      $scope.pageNumber = 1
      $scope.totalItem = 0
      $scope.books = []
      $scope.perPage = 15

      getResultsPage = ->
        Restangular.all('books').getList(
          order: 'id',
          page: $scope.pageNumber,
          per_page:  $scope.perPage
          key_words: $scope.keyWords
        ).then (data)->
          _.each data, (element, index) ->
            filterBook(element)
            _.extend element, {index: ($scope.pageNumber - 1) *10 + index + 1 }
          $scope.books = data
          $scope.totalItem = data.count

      $scope.$watchGroup ['pageNumber', 'keyWords'], ->
        getResultsPage()

      $scope.pageChanged = (page) ->
        $scope.pageNumber = page

      totalPage = ->
        $scope.totalItem / $scope.perPage

      showPath = (book) ->
        baseUrl = "books/#{book.id}"
        url = if book.has_bookmark then baseUrl + "/chapters/#{book.bookmark_chapter_id}" else baseUrl

      $scope.show = (idx) ->
        return if $scope.editMode
        $location.path(showPath($scope.books[idx]))

      $scope.editBook = (idx) ->
        $scope.books[idx].put().then () ->
          filterBook($scope.books[idx])
          _log "success!"

      filterBook = (obj) ->
        obj.word_count = $filter('number')(obj.word_count)
        obj.category = $filter('capitalize')(obj.category)

      $scope.delete = (idx) ->
        if confirm "Do you want delete remove book?"
          $scope.books[idx].remove().then ->
            $scope.books.splice idx, 1

      $scope.manageUpload = (idx) ->
        $location.path("books/#{$scope.books[idx].id}/upload")

      $scope.newBook = ->
        $scope.book = {}
        $('#newBookModal').modal('show')
        return true

      $scope.addBook = ->
        Restangular.all('books').post($scope.book).then (data) ->
          data.index = ($scope.pageNumber - 1) *10 + $scope.totalItem + 1
          $scope.books.push data
          $scope.cancel()


    ]
