ShopVibe::Application.routes.draw do
  resources :products

  match '/auth/:provider/callback' => 'authentications#create'
  post "pages/authorize"
  resources :authentications do
    get :add_friends
  end
  resources :profiles
  devise_for :users, :controllers => { :registrations => 'registrations' }
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  root :to => "pages#home"
  
end
