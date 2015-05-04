angular
  .module('homeApp',[
    'ngRoute'
    'templates'
    'restangular'
    'Devise'
    'books'
    'CustomFilter'
    'RestAngularConfig'
    'AuthConfig'
    'ui.bootstrap'
    'ui.sortable'
    'contentEditable'
  ])
  .controller 'headerController', [
    '$scope', 'Auth', ($scope, Auth) ->
      Auth.currentUser().then (user)->
        $scope.name = user.username

      $scope.logout = ->
        Auth.logout().then ->
          window.location = '/'
    ]
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider.otherwise redirectTo : '/'
  ])