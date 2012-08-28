class Spree::TireSpeedCode < ActiveRecord::Base
  attr_accessible :name
  belongs_to :variant, :class_name => "Spree::Variant"
end
