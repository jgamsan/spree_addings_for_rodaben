class Spree::TireWidth < ActiveRecord::Base
  attr_accessible :name
  belongs_to :variant
end
