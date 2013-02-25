class AddVerfiryCodeToUsers < ActiveRecord::Migration
  def change
    add_column :moode_user_plugin_users, :verify_code, :string
  end
end
