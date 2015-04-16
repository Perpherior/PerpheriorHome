Rails.application.routes.draw do
  devise_for :admins

  namespace "api" do
    namespace "v1" do
      resources :zoo_stops
    end
  end

  root to: "ui#index"
  get '/*path', to: 'ui#index'
end
