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

  def self.existe_tire?(name, width, serial, innertube, speed_code)
    ancho = Spree::TireWidth.find_by_name(width)
    ancho_1 = ancho.id unless width.nil?
    serial = Spree::TireSerial.find_by_name(serial)
    serial_1 = serial.id unless serial.nil?
    llanta = Spree::TireInnertube.find_by_name(innertube)
    llanta_1 = llanta.id unless innertube.nil?
    vel = Spree::TireSpeedCode.find_by_name(speed_code)
    vel_1 = vel.id unless speed_code.nil?
    nombre = name.to_s
    base = "Select * from spree_variants where name = #{nombre}"
    base << " and tire_width_id = #{ancho_1}" unless ancho_1.nil?
    base << " and tire_serial_id = #{serial_1}" unless serial_1.nil?
    base << " and tire_innertube_id = #{llanta_1}" unless llanta_1.nil?
    base << " and tire_speed_code_id = #{vel_1}" unless vel_1.nil?
    base << ";"

    item = Spree::Variant.find_by_sql(base)
    if item.nil?
      false
    else
      true
    end
  end
end
