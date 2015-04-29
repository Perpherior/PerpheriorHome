angular
  .module('homeApp',[
    'ngRoute'
    'templates'
    'restangular'
    'Devise'
    'books'
    'RestAngularConfig'
    'AuthConfig'
    'ui.bootstrap'
    'ui.sortable'
  ])
  .controller 'headerController', [
    '$scope', 'Auth', ($scope, Auth) ->
      Auth.currentUser().then (user)->
        $scope.name = user.email

      $scope.logout = ->
        Auth.logout().then ->
          window.location = '/'
    ]
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider.otherwise redirectTo : '/'
  ])