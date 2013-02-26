module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :username, :phone, :email
  end
end
class ChangePhoneToString < ActiveRecord::Migration
  def change
    change_column :moode_user_plugin_users, :phone, :string

    ::MoodeUserPlugin::User.all.each do|user|
      user.phone = "123456" if user.phone.nil?
      user.save
    end
  end
end
