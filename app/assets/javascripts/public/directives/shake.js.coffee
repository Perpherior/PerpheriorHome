angular.module("publicApp")
  .directive 'shakeThat', ["$animate", ($animate) ->
    (scope, element, attrs) ->
      scope.animate = () ->
        $animate.addClass(element, 'shake').then () ->
          $animate.removeClass(element, 'shake')
  ]
