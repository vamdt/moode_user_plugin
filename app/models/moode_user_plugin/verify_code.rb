module MoodeUserPlugin
  class VerifyCode < ActiveRecord::Base
    attr_accessible :code

    belongs_to :user
  end
end
