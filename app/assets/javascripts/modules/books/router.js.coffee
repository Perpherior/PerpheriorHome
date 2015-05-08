angular.module('books', ['angularFileUpload'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/books',
        templateUrl: 'books/list.html'
        controller: 'Books.IndexCtrl'
      .when "/books/:id",
        templateUrl: "books/show.html",
        controller: "Books.ShowCtrl"
      .when "/books/:id/upload",
        templateUrl: "books/upload.html",
        controller: "Books.UploadCtrl"
  ]