angular.module("RestAngularConfig", [])
  .config ["RestangularProvider", (RestangularProvider) ->
    RestangularProvider.setBaseUrl('/api/v1')

    RestangularProvider.setRequestSuffix('.json')


    RestangularProvider.addResponseInterceptor (data, operation) ->
      extractedData
      if operation is "getList"
        extractedData = data.data
        extractedData.count = data.count
      else
        extractedData = data
      return extractedData
  ]