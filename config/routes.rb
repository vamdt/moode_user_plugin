MoodeUserPlugin::Engine.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  scope "/admin" do 
    resources :users
  end

  match "/signin" => 'sessions#new'  
  match "/signout" => 'sessions#destroy'  

  match "/personalization/:token" => 'sessions#create_with_token'  

end
