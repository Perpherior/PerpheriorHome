angular.module("login", [])
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
      .when "/login",
        templateUrl: "login.html",
        controller: "LoginCtrl"
  ]