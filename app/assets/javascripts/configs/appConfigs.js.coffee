angular
  .module('homeApp')
  .config(['$locationProvider', ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider.otherwise redirectTo : '/'
  ])
  .run(['$rootScope', '$location', '$hotkey',  ($rootScope, $location, $hotkey) ->
    $rootScope.$on '$routeChangeStart', (ev, next, curr) ->
      return if _.isUndefined(curr) || _.isUndefined(curr.loadedTemplateUrl)
      templateUrl = curr.loadedTemplateUrl
      if templateUrl.includes('books') or templateUrl.includes('chapters')
        $hotkey.unbind('left')
        $hotkey.unbind('right')
        $hotkey.unbind('down')
        $hotkey.unbind('up')
  ])