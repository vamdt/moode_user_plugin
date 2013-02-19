module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :username, :phone

    scope :non_admin_users, where(:admin => false)

    def self.authenticate(username, submitted_password)
      user = find_by_username(username)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
    end

    def has_password?(submitted_password) 
      password == submitted_password
    end
  end
end
