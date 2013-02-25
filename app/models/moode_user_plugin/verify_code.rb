module MoodeUserPlugin
  class VerifyCode < ActiveRecord::Base

    attr_accessible :code

    belongs_to :user
    
    validates :code, :presence => true
    validates :code, :uniqueness => true

    def self.unused
      self.all.select do |verify_code|
        verify_code.user.nil?
      end
    end

    def alreay_bound
      not user.nil?
    end
  end
end
