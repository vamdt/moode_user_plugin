class AddAdminUser < ActiveRecord::Migration
  def up
    admin = ::MoodeUserPlugin::User.new(:username => "admin", :display_name => "admin", 
    :password => "moodepass", :email => "admin@admin.com", :phone => "123")
    admin.admin = true
    admin.save!
  end

  def down
    ::MoodeUserPlugin::User.find_by_username("admin").delete
  end
end
