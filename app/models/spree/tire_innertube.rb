class Spree::TireInnertube < ActiveRecord::Base
  attr_accessible :name, :sale_price
  has_many :variants, :class_name => "Spree::Variant"
end
