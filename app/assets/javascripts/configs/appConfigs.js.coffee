angular
  .module('homeApp')
  .config(['$locationProvider', ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider.otherwise redirectTo : '/'
  ])
  .config(['cfpLoadingBarProvider', (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.latencyThreshold = 500
  ])