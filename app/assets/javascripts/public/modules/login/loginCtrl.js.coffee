angular.module("login")
  .controller "LoginCtrl", [
    "$http"
    "$window"
    "$scope"
    "Auth"
    ($http, $window, $scope, Auth) ->
      $scope.unauthorized = false

      login = ->
        _log $scope.admin
        credentials =
          email : $scope.admin.email
          password : $scope.admin.password
        Auth.login(credentials).then (currentUser) ->
          $window.location.href = "/"
        $scope.$on 'devise:unauthorized', (event, xhr, deferred) ->
          $scope.admin.password = ""
          $scope.unauthorized = true
          $scope.animate()

      $scope.form =
        submit: (form) ->
          login()
  ]
