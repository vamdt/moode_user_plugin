# encoding: UTF-8
module MoodeUserPlugin
  class VerifyCode < ActiveRecord::Base

    attr_accessible :code, :phone

    validates :code, :presence => true
    validates :code, :uniqueness => true

    def self.batch_create(phones)
      phones.each do |phone|
        create :code => unique_random_code, :phone => phone
      end
    end

    def self.new_code(attributes = {})
      self.new attributes.merge(:code => unique_random_code)
    end

    def self.delete_codes_for_phone(phone)
      where(:phone => phone).each do |verify_code|
        verify_code.delete
      end
    end

    def bound_to_phone(phone)
      self.phone == phone
    end

    def sms_from_template(template)
      template.sub(/\{.*\}/, code)
    end

    private

    def self.unique_random_code
      begin
        code = random_number
      end while not is_unique(code)
      code.to_s
    end

    def self.is_unique(code)
      find_by_code(code).nil?
    end

    def self.random_number
      SecureRandom.random_number(10000)
    end

  end
end
