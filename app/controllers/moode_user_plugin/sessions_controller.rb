require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class SessionsController < ApplicationController
    
    def new
      redirect_by_role current_user if signed_in?
    end

    def create
      user = User.authenticate(params[:session][:username], params[:session][:password])
      if user.nil?
        flash[:error] = "Invalid username/password."
        redirect_to signin_path
      else
        sign_in user
        redirect_by_role user
      end
    end

    def create_with_token
      user = User.authenticate_with_token(params[:token])
      if user.nil?
        redirect_to signin_path
      else
        sign_in user
        redirect_to_signed_in_path
      end
    end

    def destroy
      sign_out
      redirect_to signin_path
    end

    private

    def redirect_by_role(user)
      if user.admin
        redirect_to users_path
      else
        redirect_to_signed_in_path
      end
    end

    def redirect_to_signed_in_path
      redirect_to signin_redirect_path
    end

    def signin_redirect_path
      if main_app.respond_to?('signin_redirect_path')
        main_app.signin_redirect_path
      else
        '/'
      end
    end

  end
end
