MoodeUserPlugin::Engine.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  resources :users

  match "signin" => 'sessions#new'  
  match "signout" => 'sessions#destroy'  

end
