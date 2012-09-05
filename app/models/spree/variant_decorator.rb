Spree::Variant.class_eval do
  has_one :tire_width, :class_name => "Spree::TireWidth"
  has_one :tire_serial, :class_name => "Spree::TireSerial"
  has_one :tire_innertube, :class_name => "Spree::TireInnertube"
  has_one :tire_speed_code, :class_name => "Spree::TireSpeedCode"

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
