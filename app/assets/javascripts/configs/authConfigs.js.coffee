angular
  .module('AuthConfig', ['Devise'])
  .config(['AuthProvider', (AuthProvider) ->
    AuthProvider.loginPath('/admins/sign_in.json')
    AuthProvider.logoutPath('/admins/sign_out.json')
    AuthProvider.resourceName('admin')
  ])