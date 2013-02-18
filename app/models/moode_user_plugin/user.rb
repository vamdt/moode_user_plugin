module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :role_id, :username
    
    has_one :role
  end
end
