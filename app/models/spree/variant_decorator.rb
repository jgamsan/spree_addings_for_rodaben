Spree::Variant.class_eval do
  belongs_to :tire_width, :class_name => "Spree::TireWidth"
  belongs_to :tire_serial, :class_name => "Spree::TireSerial"
  belongs_to :tire_innertube, :class_name => "Spree::TireInnertube"
  belongs_to :tire_speed_code, :class_name => "Spree::TireSpeedCode"

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
