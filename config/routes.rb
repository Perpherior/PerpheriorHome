require 'sidekiq/web'

Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ 'admin', '134071' ]
  end
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admins

  namespace "api" do
    namespace "v1" do
      resources :books do
        resources :chapters
        resources :bookmarks do
          member do
            post :update_bookmark
          end
        end
        member do
          post "upload_cover"
          post "upload_book"
        end
      end
    end
  end

  authenticated do
    root to: "ui#index"
  end

  unauthenticated do
    scope module: "public" do
      root to: "ui#index", as: :public_root
      get "/*path", to: "ui#index"
    end
  end

  get '/*path', to: 'ui#index'
end
