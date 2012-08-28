class Spree::TireInnertube < ActiveRecord::Base
  attr_accessible :name, :sale_price
  belongs_to :variant, :class_name => "Spree::Variant"
end
