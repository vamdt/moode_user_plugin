# coding:utf-8
module MoodeUserPlugin
  class User < ActiveRecord::Base
    before_create :generate_token

    scope :non_admin_users, where(:admin => false)

    attr_accessible :display_name, :password, :username, :phone, :email
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email输入格式错误！" }

    with_options :if=> (:authorizations.count <= 0) do |user|
      validates_presence_of   :email,         :message => "Email必须填写！"
      validates_presence_of   :password,      :message => "密码必须填写！"
      validates_presence_of   :display_name,  :message => "昵称必须填写！"
      validates_uniqueness_of :email,         :message => "该email已被注册！"
    end

    validates_uniqueness_of :display_name,  :message => "该昵称已被使用！"

    has_one :data_auth, :as => :accessor_authorizable

    has_many :authorizations

    def self.authenticate(username, submitted_password)
      user = find_by_username(username)
      user = find_by_email(username) if user.nil?
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
