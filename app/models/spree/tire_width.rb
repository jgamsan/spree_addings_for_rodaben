class Spree::TireWidth < ActiveRecord::Base
  attr_accessible :name, :is_mm
  has_many :variants, :class_name => "Spree::Variant"

  scope :in_moto, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_widths.id").order("spree_tire_widths.name")
  }
  scope :in_mm, lambda { where(:is_mm => true).order("name")}
end
