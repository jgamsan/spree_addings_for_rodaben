class Spree::TireSerial < ActiveRecord::Base
  attr_accessible :name
  belongs_to :variant, :class_name => "Spree::Variant"
end
