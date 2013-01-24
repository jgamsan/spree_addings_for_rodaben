Spree::Variant.class_eval do
  belongs_to :tire_width, :class_name => "Spree::TireWidth"
  belongs_to :tire_serial, :class_name => "Spree::TireSerial"
  belongs_to :tire_innertube, :class_name => "Spree::TireInnertube"
  belongs_to :tire_speed_code, :class_name => "Spree::TireSpeedCode"
  belongs_to :tire_load_code, :class_name => "Spree::TireLoadCode"
  belongs_to :tire_green_rate, :class_name => "Spree::TireGreenRate"
  belongs_to :tire_fuel_consumption, :class_name => "Spree::TireFuelConsumption"
  belongs_to :tire_wet_grip, :class_name => "Spree::TireWetGrip"

  attr_accessible :count_on_hand, :cost_price, :price, :price_in_offert, :tire_rf, :tire_position,
                  :tire_load_code_id, :tire_green_rate_id, :tire_fuel_consumption_id,
                  :tire_wet_grip_id, :tire_rolling_noise_db, :tire_rolling_noise_wave

  validates_numericality_of :tire_rolling_noise_wave, :on => :create,
                            :greater_than_or_equal_to => 1,
                            :less_than_or_equal_to => 3,
                            :message => "No es un valor Valido. Debe ser entre 1 y 3",
                            :allow_nil => true
  validates :tire_rolling_noise_db, :numericality => { :only_integer => true }, :allow_nil => true

  def cee_label
    if (tire_fuel_consumption_id == nil & tire_wet_grip_id == nil & tire_rolling_noise_db == nil & tire_rolling_noise_wave == nil)
      '????'
    else
      tire_fuel_consumption.name.to_s + tire_wet_grip.name.to_s + tire_rolling_noise_wave.to_s + tire_rolling_noise_db.to_s
    end
  end

  SEASON_OPTIONS = [
  ["Invierno", 1],
  ["Todo Tiempo", 2]
  ]

  TUBE_OPTIONS = [
  ["TL", 1],
  ["TT", 2],
  ["RU", 3]
  ]

  POSITION_OPTIONS = [
  ["Delantero", 1, "F"],
  ["Trasero", 2, "R"],
  ["Ambas", 3, "F/R"]
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
    if item.empty?
      return false
    else
      return true
    end
  end

  def self.search_tire(name, width, serial, innertube, speed_code)
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
  end

  def self.existe_moto_tire(codigo)
    existe = Spree::Variant.find_by_sku(codigo)
    if existe.nil?
      false
    else
      true
    end
  end

  def self.search_moto_tire(codigo)
    variante = Spree::Variant.find_by_sku(codigo)
    return variante unless variante.nil?
  end

end
