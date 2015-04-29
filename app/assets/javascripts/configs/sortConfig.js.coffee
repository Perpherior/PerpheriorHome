angular.module('SortConfig',['ui.sortable']
).config [
  '$provide', ($provide) ->
    $provide.decorator 'accordionDirective', ($delegate) ->
      directive = $delegate[0]
      directive.replace = true
      $delegate
    return
]
