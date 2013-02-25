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
      num = params[:vcode_number].to_i

      respond_to do |format|
        if VerifyCode.batch_create(num)
          format.html { redirect_to verify_codes_path, notice: 'Verify code was successfully created.' }
          format.json { head :created }
        else
          format.html { redirect_to verify_codes_path }
          format.json { head :unprocessable_entity }
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
