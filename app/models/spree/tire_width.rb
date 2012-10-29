class Spree::TireWidth < ActiveRecord::Base
  attr_accessible :name, :is_mm
  has_many :variants, :class_name => "Spree::Variant"

  scope :in_moto, lambda { |value|
    joins(:variants => {:product => :taxons}).where("spree_taxons.id = ?", value).group("spree_tire_widths.id").order("spree_tire_widths.name")
  }
  scope :in_mm, lambda { |value| where(:is_mm => value).order("name")}

  def self.by_measure
    tipos = ["Milimetros", "Pulgadas"]
    tipos.map do |tipo|
      [tipo, Spree::TireWidth.in_mm(tipo == "Milimetros" ? true : false).map {|c| [c.name, c.id]}]
    end
  end
end
