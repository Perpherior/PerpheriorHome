angular.module('books')
.controller 'Books.UploadCtrl', [
    '$scope'
    '$location'
    'Restangular'
    '$routeParams'
    ($scope, $location, Restangular, $routeParams) ->
      bookResource = Restangular.one('books', $routeParams.id)

      bookResource.get().then (data)->
        $scope.book = data

      $scope.save = ->
        $scope.book.put().then (data)->
          $location.path("books")
  ]