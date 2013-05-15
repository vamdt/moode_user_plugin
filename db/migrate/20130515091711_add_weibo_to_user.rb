class AddWeiboToUser < ActiveRecord::Migration
  def change
    add_column :moode_user_plugin_users, :is_weibo_user, :boolean, :default => false
  end
end
