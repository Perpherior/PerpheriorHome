angular
  .module("publicApp",[
    "ngRoute"
    "templates"
    "restangular"
    "Devise"
    "ngAnimate"
    "login"
    "AuthConfig"
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.otherwise redirectTo : "/login"
  ])