angular.module('books', [])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when '/books',
        templateUrl: 'books/list.html'
        controller: 'Books.IndexCtrl'
  ]
