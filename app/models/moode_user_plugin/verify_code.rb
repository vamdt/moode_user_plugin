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

    def self.batch_create(num)
      (1..num).each do
        create :code => unique_random_code
      end
    end

    def self.unique_random_code
      begin
        code = random_number
      end while not is_unique(code)
      code
    end

    def alreay_bound
      not user.nil?
    end

    private

    def self.is_unique(code)
      find_by_code(code).nil?
    end

    def self.random_number
      SecureRandom.random_number(10000)
    end

  end
end
