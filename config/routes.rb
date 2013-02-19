MoodeUserPlugin::Engine.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  scope "/admin" do 
    resources :users
  end

  match "signin" => 'sessions#new'  
  match "signout" => 'sessions#destroy'  

end
