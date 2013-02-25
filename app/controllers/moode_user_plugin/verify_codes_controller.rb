require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class VerifyCodesController < ApplicationController

    before_filter :admin_authenticate, :except => [:send_vcode]    

    def index
      @verify_codes = VerifyCode.unused
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @verify_codes }
      end
    end

    def batch
      @verify_code = VerifyCode.new(params[:verify_code])
  
      respond_to do |format|
        if @verify_code.save
          format.html { redirect_to @verify_code, notice: 'Verify code was successfully created.' }
          format.json { render json: @verify_code, status: :created, location: @verify_code }
        else
          format.html { render action: "new" }
          format.json { render json: @verify_code.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @verify_code = VerifyCode.find(params[:id])
      @verify_code.destroy
  
      respond_to do |format|
        format.html { redirect_to verify_codes_url }
        format.json { head :no_content }
      end
    end

    def send_vcode
      phone = params[:phone]

      respond_to do |format|
        format.json { head :status => :ok }
      end
    end
  end
end
