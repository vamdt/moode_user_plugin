module MoodeUserPlugin
  class User < ActiveRecord::Base
    before_create :generate_token

    scope :non_admin_users, where(:admin => false)

    attr_accessible :display_name, :password, :username, :phone, :email
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
    validates :phone, :presence => true
    validates :username, :email, :phone, :uniqueness => true

    has_one :data_auth, :as => :accessor_authorizable

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

    def as_json(options)
      super({ :only => [:username, :display_name, :phone, :created_at, :token]}.merge(options || {}))
    end
    
  end
end
