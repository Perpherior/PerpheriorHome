angular
  .module("AuthConfig",["Devise"])
  .config(["$locationProvider", ($locationProvider) ->
    $locationProvider.html5Mode(true)
  ])
  .config(["AuthProvider", (AuthProvider) ->
    AuthProvider.loginPath("/admins/sign_in.json")
    AuthProvider.logoutPath("/admins/sign_out.json")
    AuthProvider.resourceName('admin')
  ])