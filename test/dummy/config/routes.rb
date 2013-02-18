Rails.application.routes.draw do

  mount MoodeUserPlugin::Engine => "/moode_user_plugin"
end
