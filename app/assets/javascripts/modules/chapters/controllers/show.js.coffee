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
    '$q'
    '$interval'
    '$localStorage'
    ($scope, $routeParams, $location, Restangular, $hotkey, $document, $q, $interval, $localStorage) ->
      bookResource = Restangular.one('books', $routeParams.bookId)
      chapterResource = bookResource.one('chapters', $routeParams.id)
      bookmarkResource = bookResource.one('bookmarks', 0)
      $scope.currentOffset = 0
      scrollOffset = 400
      $scope.tempOffset = 0
      $scope.showPrefBar = false
      defaultPref = {
        light: false
      }
      $scope.readingPref = $localStorage.readingPref || defaultPref
      _log $scope.readingPref.light

      # ----
      # setting preference of reading
      updateReadingPref = ->
        $localStorage.readingPref = $scope.readingPref

      $scope.toggleLight = ->
        $scope.readingPref.light = !$scope.readingPref.light
        updateReadingPref()

      defer = $q.all([chapterResource.get(), bookmarkResource.get()])

      defer.then (data) ->
        $scope.chapter = data[0]
        $scope.range = data[0].chapter_range
        if data[1].chapter_id == data[0].id
          $scope.bookmark = data[1]
          $scope.currentOffset = data[1].offset if data[1]
          $document.scrollTopAnimated($scope.currentOffset)
        else
          $scope.bookmark = {}

      $scope.locateTo = (destination) ->
        if  destination == 'menu'
          $location.path("/books/#{$routeParams.bookId}")
        else if destination == 'bookList'
          $location.path('/books')


      $scope.jumpTo = (id) ->
        $location.path(buildPath() + id) if inRange(id, $scope.range)

      buildPath = ->
        last = $location.url().lastIndexOf('/')
        url = $location.url().slice 0, last + 1

      inRange = (id, range) ->
        if id >= range.start && id <= range.end then true else false

      # events binding
      # including 'key up/down/right/left'
      # update bookmark while scroll offset changed
      $hotkey.bind 'left', (event) ->
        $scope.jumpTo($scope.chapter.id - 1)

      $hotkey.bind 'right', (event) ->
        $scope.jumpTo($scope.chapter.id + 1)

      $hotkey.bind 'down', (event) ->
        $document.scrollTopAnimated(scrollDown(scrollOffset))

      $hotkey.bind 'up', (event) ->
        $document.scrollTopAnimated(scrollUp(scrollOffset))

      scrollDown = (offset) ->
        $scope.currentOffset + offset

      scrollUp = (offset) ->
        $scope.currentOffset - offset

      $document.on 'scroll', ->
        $scope.currentOffset = $document.scrollTop()

      # update bookmark if tempOffset differs currentOffset
      $scope.$watch 'tempOffset', ->
        updateBookmark()

      # update tempOffset every 5s
      $interval(
        ->
          $scope.tempOffset = $document.scrollTop()
      , 5000)

      updateBookmark = ->
        if $scope.bookmark
          $scope.bookmark.chapter_id = $scope.chapter.id
          $scope.bookmark.offset = $scope.currentOffset
          bookmarkResource.customPOST({bookmark: $scope.bookmark},'update_bookmark' ,{})
  ]
