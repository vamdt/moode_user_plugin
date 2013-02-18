module MoodeUserPlugin
  class User < ActiveRecord::Base
    attr_accessible :display_name, :password, :role, :username

    belongs_to :role
  end
end
