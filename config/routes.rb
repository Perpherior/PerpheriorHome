Rails.application.routes.draw do
  devise_for :admins

  namespace "api" do
    namespace "v1" do
      resources :books
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
