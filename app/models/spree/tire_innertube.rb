class Spree::TireInnertube < ActiveRecord::Base
  attr_accessible :name, :sale_price
  has_many :variants, :class_name => "Spree::Variant"

  scope :in_moto, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_innertubes.id").order("spree_tire_innertubes.name")
  }
end
