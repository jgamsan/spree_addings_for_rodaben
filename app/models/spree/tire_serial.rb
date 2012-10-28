class Spree::TireSerial < ActiveRecord::Base
  attr_accessible :name, :is_mm
  has_many :variants, :class_name => "Spree::Variant"

  scope :in_moto, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_serials.id").order("spree_tire_serials.name")
  }
end
