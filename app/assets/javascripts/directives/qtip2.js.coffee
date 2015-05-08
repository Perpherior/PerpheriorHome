angular.module('qtip2', [])
  .directive 'qtip', ->
    restrict: 'A'
    scope: qtipVisible: '='
    link: (scope, element, attrs) ->
      my = attrs.qtipMy or 'bottom center'
      at = attrs.qtipAt or 'top center'
      qtipClass = attrs.qtipClass or 'qtip-youtube qtip-shadow qtip-rounded'
      content = attrs.qtipContent or attrs.qtip
      if attrs.qtipTitle
        content =
          'title': attrs.qtipTitle
          'text': attrs.qtip
      $(element).qtip
        content: content
        position:
          my: my
          at: at
          target: element
        show:
          delay: 500
          effect: (offset) ->
            $(this).fadeIn 400
        hide:
          delay: 300
          effect: (offset) ->
            $(this).fadeOut 400
        style: qtipClass
      if attrs.qtipVisible
        scope.$watch 'qtipVisible', (newValue, oldValue) ->
          $(element).qtip 'toggle', newValue
          return
      return