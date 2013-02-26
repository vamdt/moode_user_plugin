class CreateMoodeUserPluginDataAuths < ActiveRecord::Migration
  def change
    create_table :moode_user_plugin_data_auths do |t|
      t.integer :level
      t.string :name
      t.references :data_authorizable, :polymorphic => true
      t.timestamps
    end
  end
end
