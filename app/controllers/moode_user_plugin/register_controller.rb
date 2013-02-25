require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class RegisterController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(params[:user])
      @verify_code = VerifyCode.find_by_code(params[:verify_code])

      respond_to do |format|
        if is_valid_verify_code_for_user(@verify_code, @user) && @user.save_with_verify_code(@verify_code)
          format.html { redirect_to signin_path, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def is_valid_verify_code_for_user(verify_code, user)
      if verify_code.nil?
        user.errors.add(:verify_code, "not right")
        false
      elsif verify_code.alreay_bound
        user.errors.add(:verify_code, "has alreay bound with others")
        false                      
      else
        true
      end
    end
  end
end
