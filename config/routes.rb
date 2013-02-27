MoodeUserPlugin::Engine.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
  scope "/admin" do 
    resources :users
    resources :verify_codes, :only => [:index, :destroy]
    match "/verify_codes/batch" => 'verify_codes#batch', :via => :post
  end

  match "/signin" => 'sessions#new'  
  match "/signout" => 'sessions#destroy'  
  match "/signup" => 'register#new', :via => :get, :as => 'signup'
  match "/signup" => 'register#create', :via => :post

  match "/settings" => 'settings#show', :via => :get  
  match "/settings/edit" => 'settings#edit', :via => :get , :as => "edit_settings"
  match "/settings" => 'settings#update', :via => :put, :as => "update_settings"

  match "/phone/:phone/vcode" => 'verify_codes#send_vcode'

  match "/p/:token" => 'sessions#create_with_token'  

  scope '/api' do
    scope '/v1' do
      match '/signin' => 'account_api#signin', :via => :post
    end
  end
  
end
