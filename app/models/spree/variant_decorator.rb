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

  def existe_tire?(name, width, serial, innertube, speed_code)
    ancho = Spree::TireWidth.find_by_name(width) unless width.nil?
    serial = Spree::TireSerial.find_by_name(serial) unless serial.nil?
    llanta = Spree.TireInnertube.find_by_name(innertube) unless innertube.nil?
    vel = Spree::TireSpeedCode.find_by_name(speed_code) unless speed_code.nil?

    base = "Select * from spree_variants where name = #{name}"
    base << " and tire_width_id = #{ancho}" unless ancho.nil?
    base << " and tire_serial_id = #{serial}" unless serial.nil?
    base << " and tire_innertube_id = #{llanta}" unless llanta.nil?
    base << " and tire_speed_code_id = #{vel}" unless vel.nil?
    base << ";"

    item = Spree::Variant.find_by_sql(base)
    if item.nil?
      false
    else
      true
    end
  end
end
