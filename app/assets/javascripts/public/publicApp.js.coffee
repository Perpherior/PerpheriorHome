angular
  .module("publicApp",[
    "ngRoute"
    "templates"
    "restangular"
    "Devise"
    "login"
    "AuthConfig"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.otherwise redirectTo : "/login"
  ])