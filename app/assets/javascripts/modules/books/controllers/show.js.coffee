angular.module('books')
  .controller 'Books.ShowCtrl', [
    '$scope'
    '$location'
    'Restangular'
    '$routeParams'
    '$hotkey'
    ($scope, $location, Restangular, $routeParams, $hotkey) ->
      $scope.pageNumber = 1
      $scope.totalItem = 0
      $scope.chapters = []
      $scope.perPage = 51

      bookResource = Restangular.one('books', $routeParams.id)
      chaptersResource = bookResource.all('chapters')

      $scope.$watch 'pageNumber', ->
        getResultsPage()

      bookResource.get().then (data) ->
        $scope.book = data

      getResultsPage = ->
        chaptersResource.getList(
          order: 'id',
          page: $scope.pageNumber,
          per_page:  $scope.perPage
        ).then (data)->
          $scope.chapters = data
          $scope.totalItem = data.count

      $scope.pageChanged = (page) ->
        $scope.pageNumber = page

      $scope.showChapter = (id) ->
        $location.path("books/#{$routeParams.id}/chapters/#{id}")

      totalPage = ->
        $scope.totalItem / $scope.perPage

      #hotkey
      $hotkey.bind 'left', (event) ->
        if $scope.pageNumber >= 1
          prePage()

      $hotkey.bind 'right', (event) ->
        if $scope.pageNumber <= totalPage()
          nextPage()

      nextPage = ->
        $scope.pageNumber += 1
        next = $('.active').next('li')
        $('.active').removeClass('active')
        next.addClass('active')
      prePage = ->
        $scope.pageNumber -= 1
        pre = $('.active').prev('li')
        $('.active').removeClass('active')
        pre.addClass('active')

    ]
