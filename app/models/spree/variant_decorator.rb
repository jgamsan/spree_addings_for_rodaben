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
    ancho = Spree::TireWidth.find_by_name(width) unless width.blank?
    ancho_1 = ancho.id unless ancho.nil?
    serial = Spree::TireSerial.find_by_name(serial) unless serial.blank?
    serial_1 = serial.id unless serial.nil?
    llanta = Spree::TireInnertube.find_by_name(innertube) unless innertube.blank?
    llanta_1 = llanta.id unless llanta.nil?
    vel = Spree::TireSpeedCode.find_by_name(speed_code) unless speed_code.blank?
    vel_1 = vel.id unless vel.nil?
    nombre = name.to_s
    base = "Select * from spree_products as a, spree_variants as b where a.name = '#{nombre}' and b.product_id = a.id"
    base << " and b.tire_width_id = #{ancho_1}" unless ancho_1.nil?
    base << " and b.tire_serial_id = #{serial_1}" unless serial_1.nil?
    base << " and b.tire_innertube_id = #{llanta_1}" unless llanta_1.nil?
    base << " and b.tire_speed_code_id = #{vel_1}" unless vel_1.nil?
    base << ";"

    item = Spree::Variant.find_by_sql(base)
    if item.nil?
      false
    else
      true
    end
  end

  def self.search_tire(name, width, serial, innertube, speed_code)
    ancho = Spree::TireWidth.find_by_name(width) unless width.nil?
    ancho_1 = ancho.id unless ancho.nil?
    serial = Spree::TireSerial.find_by_name(serial) unless serial.nil?
    serial_1 = serial.id unless serial.nil?
    llanta = Spree::TireInnertube.find_by_name(innertube) unless innertube.nil?
    llanta_1 = llanta.id unless llanta.nil?
    vel = Spree::TireSpeedCode.find_by_name(speed_code) unless speed_code.nil?
    vel_1 = vel.id unless vel.nil?
    nombre = name.to_s
    base = "Select * from spree_products as a, spree_variants as b where a.name = '#{nombre}' and b.product_id = a.id"
    base << " and b.tire_width_id = #{ancho_1}" unless ancho_1.nil?
    base << " and b.tire_serial_id = #{serial_1}" unless serial_1.nil?
    base << " and b.tire_innertube_id = #{llanta_1}" unless llanta_1.nil?
    base << " and b.tire_speed_code_id = #{vel_1}" unless vel_1.nil?
    base << ";"

    item = Spree::Variant.find_by_sql(base)
  end

end
