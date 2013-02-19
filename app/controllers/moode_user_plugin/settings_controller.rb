require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class SettingsController < ApplicationController
    before_filter :non_admin_authenticate    

    def show
      @user = current_user
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end

    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      @user.generate_token if params[:is_regenerate_token] == "yes"
      
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to settings_path, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
