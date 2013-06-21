# coding: utf-8
require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class SessionsController < ApplicationController
    
    def new
      redirect_by_role current_user if signed_in?
    end

    def create
      user = User.authenticate(params[:session][:email], params[:session][:password])

      respond_to do |format|
        if user.nil?
          errors ||= [] << "邮箱或密码错误！"
          format.html { redirect_to signin_path }
          format.json { render json: {:errors => errors, :succeed => false} }
        else
          sign_in user
          format.html {redirect_by_role user }
          format.json {render json: {:succeed => true, :admin => (user.admin ? true : false)}}
        end
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
      redirect_to "/"
    end

    private

    def redirect_by_role(user)
      if user.admin
        redirect_to "/admin"
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
