Spree::Variant.class_eval do
  has_many :tire_widths
  has_many :tire_serials
  has_many :tire_innertubes
  has_many :tire_speed_codes
  
  attr_accessible :count_on_hand, :cost_price, :price
  
  SEASON_OPTIONS = [
  ["Si", 1],
  ["No", 2],
  ["Todo Tiempo", 3]
  ]
end
