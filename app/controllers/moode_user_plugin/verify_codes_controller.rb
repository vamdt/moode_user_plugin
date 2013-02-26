require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class VerifyCodesController < ApplicationController
    before_filter :admin_authenticate, :except => [:send_vcode]    

    def index
      @verify_codes = VerifyCode.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @verify_codes }
      end
    end

    def batch
      phones = extract_phones(params[:phones])

      respond_to do |format|
        if VerifyCode.batch_create(phones)
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
      verify_code = VerifyCode.new_code(:phone => params[:phone])

      sms_service = SMSService.new(MoodeUserPlugin.sms_server_config, HTTParty)
      sms_template = MoodeUserPlugin.verify_code_message_template

      sms_response = sms_service.send_msg_to_phone(verify_code.sms_from_template(sms_template), verify_code.phone)

      respond_to do |format|
        if sms_response.ok && verify_code.save
          format.json { head :status => :no_content }
        else
          format.json { render json: sms_response.error, status: :error }
        end
      end
    end

    private

    def extract_phones(phones_text)
      phones_text.split(/ |,|;|\n/).map do |phone_string|
        phone_string.strip
      end.delete_if { |phone| phone == "" }
    end
  end
end
