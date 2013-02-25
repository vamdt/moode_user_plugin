class ChangeVerifyCodeIdToInteger < ActiveRecord::Migration
  def change
    change_column :moode_user_plugin_users, :verify_code_id, :integer
  end
end
