class Spree::TireSpeedCode < ActiveRecord::Base
  attr_accessible :name
  has_many :variants, :class_name => "Spree::Variant"

  scope :by_taxon, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_speed_codes.id").order("spree_tire_speed_codes.name")
  }
end
