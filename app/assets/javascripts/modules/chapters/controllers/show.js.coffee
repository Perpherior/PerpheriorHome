angular.module('chapters')
  .value('duScrollDuration', 500)
  .value('duScrollOffset', 30)
  .controller 'Chapters.ShowCtrl', [
    '$scope'
    '$routeParams'
    '$location'
    'Restangular'
    '$hotkey'
    '$document'
    ($scope, $routeParams, $location, Restangular, $hotkey, $document) ->
      bookResource = Restangular.one('books', $routeParams.bookId)
      chapterResource = bookResource.one('chapters', $routeParams.id)
      $scope.currentOffset = 0

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

      $hotkey.bind 'left', (event) ->
        $scope.jumpTo($scope.chapter.id - 1)

      $hotkey.bind 'right', (event) ->
        $scope.jumpTo($scope.chapter.id + 1)

      $hotkey.bind 'down', (event) ->
        $document.scrollTopAnimated(scrollDown(400))

      $hotkey.bind 'up', (event) ->
        $document.scrollTopAnimated(scrollUp(400))
      scrollDown = (offset) ->
        $scope.currentOffset + offset

      scrollUp = (offset) ->
        $scope.currentOffset - offset

      $document.on 'scroll', () ->
        $scope.currentOffset = $document.scrollTop()

  ]