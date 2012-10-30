class Spree::TireInnertube < ActiveRecord::Base
  attr_accessible :name, :sale_price, :is_mm
  has_many :variants, :class_name => "Spree::Variant"

  scope :by_taxon, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_innertubes.id").order("spree_tire_innertubes.name")
  }
  scope :in_mm, lambda { |value| where(:is_mm => value).order("name")}
end
