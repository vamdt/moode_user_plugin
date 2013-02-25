class CreateMoodeUserPluginVerifyCodes < ActiveRecord::Migration
  def change
    create_table :moode_user_plugin_verify_codes do |t|
      t.string :code
      t.integer :user_id
      t.timestamps
    end
  end
end
