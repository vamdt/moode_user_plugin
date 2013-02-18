module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :role, :username
  end
end
