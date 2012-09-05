class Spree::TireSerial < ActiveRecord::Base
  attr_accessible :name
  has_many :variants, :class_name => "Spree::Variant"
end
