angular.module("contentEditable", [])
  .directive "contenteditable", ->
    require: "ngModel",
    link: (scope, element, attrs, ngModel) ->
      read = ->
         ngModel.$setViewValue(element.text())

      ngModel.$render = ->
        element.html(ngModel.$viewValue || "")

      element.bind "blur keyup change", (event) ->
        scope.$apply(read)