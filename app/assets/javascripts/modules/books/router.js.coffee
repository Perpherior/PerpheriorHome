angular.module('books', ['angularFileUpload'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/books',
        templateUrl: 'books/list.html'
        controller: 'Books.IndexCtrl'
      .when "/books/:id/edit",
        templateUrl: "books/edit.html",
        controller: "Books.EditCtrl"
  ]
