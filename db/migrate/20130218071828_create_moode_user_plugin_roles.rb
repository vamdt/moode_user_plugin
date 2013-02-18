class CreateMoodeUserPluginRoles < ActiveRecord::Migration
  def change
    create_table :moode_user_plugin_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
