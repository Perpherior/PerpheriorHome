angular.module('books')
  .controller 'Books.EditCtrl', [
    '$scope'
    '$location'
    'Restangular'
    '$routeParams'
    '$upload'
    ($scope, $location, Restangular, $routeParams, $upload) ->
      Restangular.one('books', $routeParams.id).get().then (data)->
        $scope.book = data

      $scope.onFileSelect = ($file) ->
        $scope.upload = $upload.upload(
          url: '/api/v1/books/'+ $routeParams.id + '/upload_cover'
          file: $file
        ).success( (data, status, headers, config) ->
        	$scope.book.cover_img_url = data.cover_img_url
        ).error( (error) ->
          $scope.errorMessage = error.errors
          $scope.showErrors = true
        )

	]