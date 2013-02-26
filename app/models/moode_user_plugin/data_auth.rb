module MoodeUserPlugin
  class DataAuth < ActiveRecord::Base
    attr_accessible :level, :name

    validates :level, :numericality => { :greater_than_or_equal_to => 0 }
    validates :level, :uniqueness => true

    belongs_to :data_authorizable, :polymorphic => true
    belongs_to :accessor_authorizable, :polymorphic => true
  end
end
