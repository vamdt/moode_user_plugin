require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class SessionsController < ApplicationController
    include SessionsHelper
    
    def new
      redirect_to_root if signed_in?
    end

    def create
      user = User.authenticate(params[:session][:username], params[:session][:password])
      if user.nil?
        flash[:error] = "Invalid username/password."
      else
        sign_in user
      end

      redirect_to_root
    end

    def destroy
      sign_out
      redirect_to_root
    end

    private

    def redirect_to_root
      redirect_to '/'
    end

  end
end
