class CreateMoodeUserPluginAuthorizations < ActiveRecord::Migration
  def change
    create_table :moode_user_plugin_authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id

      t.timestamps
    end
  end
end
