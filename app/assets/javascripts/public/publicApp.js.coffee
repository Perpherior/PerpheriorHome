angular
  .module("publicApp",[
    "ngRoute"
    "templates"
    "restangular"
    "Devise"
    "ngAnimate"
    "login"
  ])
  .config(["$locationProvider", ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])
  .config(["AuthProvider", (AuthProvider) ->
    AuthProvider.loginPath("/admins/sign_in.json")
    AuthProvider.logoutPath("/admins/sign_out.json")
  ])
  .config(["$routeProvider", ($routeProvider) ->
    $routeProvider.otherwise redirectTo : "/login"
  ])