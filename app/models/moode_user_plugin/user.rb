module MoodeUserPlugin
  class User < ActiveRecord::Base
    before_create :generate_token

    scope :non_admin_users, where(:admin => false)

    has_one :verify_code
    
    attr_accessible :display_name, :password, :username, :phone, :email
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :username, :email, :phone, :presence => true

    def self.authenticate(username, submitted_password)
      user = find_by_username(username)
      return nil if user.nil?
      return user if user.has_password?(submitted_password)
    end

    def self.authenticate_with_token(token)
      find_by_token(token)
    end

    def has_password?(submitted_password) 
      password == submitted_password
    end

    def generate_token
      begin
        token = SecureRandom.urlsafe_base64
      end while User.where(:token => token).exists?
      self.token = token
    end

    def save_with_verify_code(verify_code)
      self.verify_code = verify_code  
      save
    end
  end
end
