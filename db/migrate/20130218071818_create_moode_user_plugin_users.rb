class CreateMoodeUserPluginUsers < ActiveRecord::Migration
  def change
    create_table :moode_user_plugin_users do |t|
      t.string :username
      t.string :display_name
      t.string :password
      t.integer :role_id

      t.timestamps
    end
  end
end
