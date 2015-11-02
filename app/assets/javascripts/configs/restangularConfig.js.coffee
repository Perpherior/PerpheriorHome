angular.module("RestAngularConfig", [])
  .config ["RestangularProvider", (RestangularProvider) ->
    RestangularProvider.setBaseUrl('/api/v1')

    RestangularProvider.setRequestSuffix('.json')

    RestangularProvider.addResponseInterceptor (data, operation) ->
      angular.element('.loading').removeClass('active')
      extractedData
      if operation is "getList"
        extractedData = data.data
        extractedData.count = data.count
      else
        extractedData = data
      return extractedData

    RestangularProvider.addRequestInterceptor (element, operation, what) ->
      if what != 'update_bookmark' && what != 'books'
        angular.element('.loading').addClass('active')
      return element
  ]