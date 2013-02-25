class RenameVerifyCodeToVerifyCodeId < ActiveRecord::Migration
  def change
    rename_column :moode_user_plugin_users, :verify_code, :verify_code_id 
  end
end
