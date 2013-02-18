require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class SessionsController < ApplicationController
    include SessionsHelper
    
    def new
      redirect_by_role current_user if signed_in?
    end

    def create
      user = User.authenticate(params[:session][:username], params[:session][:password])
      if user.nil?
        flash[:error] = "Invalid username/password."
        redirect_to_root
      else
        sign_in user
        redirect_by_role user
      end
    end

    def destroy
      sign_out
      redirect_to_root
    end

    private

    def redirect_to_root
      redirect_to '/'
    end

    def redirect_by_role(user)
      if user.admin
        redirect_to users_path
      else
        redirect_to_root
      end
    end

  end
end
