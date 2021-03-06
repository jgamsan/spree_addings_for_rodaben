class Spree::TireSerial < ActiveRecord::Base
  attr_accessible :name, :is_mm
  has_many :variants, :class_name => "Spree::Variant"

  scope :by_taxon, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_serials.id").order("spree_tire_serials.name")
  }
  scope :in_mm, lambda { |value| where(:is_mm => value).order("name")}
end
