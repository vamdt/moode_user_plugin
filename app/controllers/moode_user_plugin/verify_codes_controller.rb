require_dependency "moode_user_plugin/application_controller"

module MoodeUserPlugin
  class VerifyCodesController < ApplicationController

    before_filter :admin_authenticate    

    # GET /verify_codes
    # GET /verify_codes.json
    def index
      @verify_codes = VerifyCode.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @verify_codes }
      end
    end
  
    # GET /verify_codes/1
    # GET /verify_codes/1.json
    def show
      @verify_code = VerifyCode.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @verify_code }
      end
    end
  
    # GET /verify_codes/new
    # GET /verify_codes/new.json
    def new
      @verify_code = VerifyCode.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @verify_code }
      end
    end
  
    # GET /verify_codes/1/edit
    def edit
      @verify_code = VerifyCode.find(params[:id])
    end
  
    # POST /verify_codes
    # POST /verify_codes.json
    def create
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
  
    # PUT /verify_codes/1
    # PUT /verify_codes/1.json
    def update
      @verify_code = VerifyCode.find(params[:id])
  
      respond_to do |format|
        if @verify_code.update_attributes(params[:verify_code])
          format.html { redirect_to @verify_code, notice: 'Verify code was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @verify_code.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /verify_codes/1
    # DELETE /verify_codes/1.json
    def destroy
      @verify_code = VerifyCode.find(params[:id])
      @verify_code.destroy
  
      respond_to do |format|
        format.html { redirect_to verify_codes_url }
        format.json { head :no_content }
      end
    end
  end
end
