module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :username, :phone
    before_create :generate_token

    scope :non_admin_users, where(:admin => false)

    def self.authenticate(username, submitted_password)
      user = find_by_username(username)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
    end

    def has_password?(submitted_password) 
      password == submitted_password
    end

    private

    def generate_token
      begin
        token = SecureRandom.urlsafe_base64
      end while User.where(:token => token).exists?
      self.token = token
    end

  end
end
