module MoodeUserPlugin
  module SessionsHelper
    def sign_in(user, remember_me=false)
      create_remember_me_cookie(remember_me, user)
      session[:user_id] = user.id
      self.current_user = user
    end

    def create_remember_me_cookie(remember_me, user)
      if remember_me == true
        user.create_remember_token
        cookies[:remember_token] = {
            :value => user.remember_token,
            :expires => 1.weeks.from_now.utc
        }
      end
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_out
      cookies.delete :remember_token
      session[:user_id] = nil
      current_user= nil
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= user_from_remember_token
      @current_user ||= user_from_cookie
    end

    def deny_access
      redirect_to '/signin', :notice => "Please sign in to access this page."
    end

    def non_admin_authenticate
      deny_access unless signed_in? && ( not current_user.admin )
    end

    def admin_authenticate
      deny_access unless signed_in? && current_user.admin
    end
    
    private

    def user_from_cookie
      User.find_by_remember_token cookies[:remember_token] if cookies[:remember_token]
    end

    def user_from_remember_token 
      User.find_by_id(remember_token)
    end

    def remember_token 
      session[:user_id] || nil
    end
  end
end
