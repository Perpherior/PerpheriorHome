angular
  .module('homeApp',[
    'ngRoute'
    'templates'
    'restangular'
    'Devise'
    'qtip2'
    'CustomFilter'
    'RestAngularConfig'
    'AuthConfig'
    'ui.bootstrap'
    'contentEditable'
    'angularUtils.directives.dirPagination'
    'books'
    'chapters'
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
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider.otherwise redirectTo : '/'
  ])