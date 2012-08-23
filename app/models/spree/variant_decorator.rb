Spree::Variant.class_eval do
  has_many :tire_widths
  has_many :tire_serials
  has_many :tire_innertubes
  has_many :tire_speed_codes

  attr_accessible :count_on_hand, :cost_price, :price, :price_in_offert

  SEASON_OPTIONS = [
  ["Invierno", 1],
  ["Todo Tiempo", 2]
  ]

  TUBE_OPTIONS = [
  ["TL", 1],
  ["TT", 2],
  ["RU", 3]
  ]
end
