angular.module('books')
  .controller 'Books.ShowCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    'Restangular'
    ($scope, $routeParams, $location, Restangular) ->
      $scope.pageNumber = 1
      $scope.totalPage = 0
      $scope.chapters = []
      $scope.perPage = 10

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
          $scope.totalPage = data.count

      $scope.pageChanged = (page) ->
        $scope.pageNumber = page
        getResultsPage(page)

    ]
