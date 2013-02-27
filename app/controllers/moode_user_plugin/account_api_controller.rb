require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class AccountApiController < ApplicationController

    respond_to :js

    def signin
      user = User.authenticate(params[:username], params[:password])
      unless user.nil?
        respond_with {:token => user.token }.to_json, :status => :ok
      else
        respond_with "Invalid username or password.", :status => :unauthorized
      end
    end

  end
end
