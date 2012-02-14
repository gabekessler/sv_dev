ShopVibe::Application.routes.draw do
  resources :products

  match '/auth/:provider/callback' => 'authentications#create'
  post "pages/authorize"
  resources :authentications do
    get :add_friends
  end
  resources :profiles
  
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :registrations => 'registrations' }
  root :to => "pages#home"
  
end
