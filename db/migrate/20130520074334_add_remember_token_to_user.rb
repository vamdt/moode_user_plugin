class AddRememberTokenToUser < ActiveRecord::Migration
  def change
    add_column :moode_user_plugin_users, :remember_token, :string
  end
end