angular.module('books')
.controller 'Books.UploadCtrl', [
    '$scope'
    '$location'
    'Restangular'
    '$routeParams'
    '$upload'
    ($scope, $location, Restangular, $routeParams, $upload) ->
      bookResource = Restangular.one('books', $routeParams.id)

      bookResource.get().then (data)->
        $scope.book = data

      $scope.uploadCoverPage = ($file) ->
        $scope.upload = $upload.upload(
          url: '/api/v1/books/'+ $routeParams.id + '/upload_cover'
          file: $file
          headers: {'Accept': 'application/json'}
        ).success( (data, status, headers, config) ->
        	$scope.book.cover_img_url = data.cover_img_url
        ).error( (error) ->
          $scope.errorMessage = error.errors
          $scope.showErrors = true
        )

      $scope.uploadBook = ($file) ->
        $scope.upload = $upload.upload(
          url: '/api/v1/books/'+ $routeParams.id + '/upload_book'
          file: $file
          headers: {'Accept': 'application/json'}
        ).success( (data, status, headers, config) ->
          _log data
        ).error( (error) ->
          $scope.errorMessage = error.errors
          $scope.showErrors = true
        )

	]