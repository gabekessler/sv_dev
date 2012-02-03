ShopVibe::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'
  resources :authentications
  resources :profiles
  devise_for :users, :controllers => { :registrations => 'registrations' }
  
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  root :to => "pages#home"
  
end
