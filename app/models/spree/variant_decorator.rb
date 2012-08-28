Spree::Variant.class_eval do
  has_many :tire_widths, :class_name => "Spree::TireWidth"
  has_many :tire_serials, :class_name => "Spree::TireSerial"
  has_many :tire_innertubes, :class_name => "Spree::TireInnertube"
  has_many :tire_speed_codes, :class_name => "Spree::TireSpeedCode"

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
