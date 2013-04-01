require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class AccountApiController < ApplicationController

    respond_to :js

    def signin
      user = User.authenticate(params[:username], params[:password])
      unless user.nil?
        render :json => user, :status => :accepted
      else
        render :json => {:message => "Invalid username or password."}, :status => :unauthorized
      end
    end

  end
end
