angular.module('chapters', ['drahak.hotkeys', 'duScroll'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when "/books/:bookId/chapters/:id",
        templateUrl: "chapters/show.html",
        controller: "Chapters.ShowCtrl"
  ]
