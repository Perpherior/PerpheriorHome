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
      unless what == 'update_bookmark'
        angular.element('.loading').addClass('active')
      return element
  ]