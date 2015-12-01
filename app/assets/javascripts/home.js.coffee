angular
  .module('homeApp',[
    'ngRoute'
    'ngFileUpload'
    'templates'
    'restangular'
    'Devise'
    'qtip2'
    'CustomFilter'
    'RestAngularConfig'
    'AuthConfig'
    'ui.bootstrap'
    'ui.bootstrap-slider'
    'contentEditable'
    'angularUtils.directives.dirPagination'
    'ngStorage'
    'cloudinary'

    # modules
    'books'
    'chapters'

    #directives
    'directive.ng-upload'

  ])
  .controller 'headerController', [
    '$scope', 'Auth', '$location', ($scope, Auth, $location) ->
      Auth.currentUser().then (user)->
        $scope.name = user.username

      $scope.logout = ->
        Auth.logout().then ->
          $location.path '/'

      $scope.jumpTo = (destination) ->
        $location.path '/'+ destination
    ]