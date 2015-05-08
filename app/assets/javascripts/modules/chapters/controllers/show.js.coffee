angular.module('chapters')
  .controller 'Chapters.ShowCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    'Restangular'
    ($scope, $routeParams, $location, Restangular) ->
      bookResource = Restangular.one('books', $routeParams.bookId)
      chapterResource = bookResource.one('chapters', $routeParams.id)

      chapterResource.get().then (data) ->
        $scope.chapter = data
        $scope.range = data.chapter_range

      $scope.jumpTo = (id) ->
        $location.path(buildPath() + id) if inRange(id, $scope.range)

      buildPath = ->
        last = $location.url().lastIndexOf('/')
        url = $location.url().slice 0, last + 1

      inRange = (id, range) ->
        if id >= range.start && id <= range.end then true else false

  ]