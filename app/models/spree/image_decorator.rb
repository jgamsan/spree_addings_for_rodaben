Spree::Image.class_eval do
  Spree::Image.attachment_definitions[:attachment][:styles].merge!(
      "ceelabel" => {:processors => [:greenlabel]},
      "offertmark" => {:processors => [:offertmark]},
      "newmark" => {:processors => [:newmark]}
  )

  after_save :check_cee_label, :on => :create

  def check_cee_label
    variante = Spree::Variant.find(self.viewable_id)
    if (variante.images.count == 1 && !variante.tire_fuel_consumption_id.nil?)
      update_cee_label_imagen(self, variante)
    end
  end

  private

  def update_cee_label_imagen(imagen, variant)
    @fuel_options = Hash["A", "-14-55", "B", "-13-33", "C", "-13-11", "D", "-13+11", "E", "-13+33", "F", "-13+55", "G", "-13+77"]
    @wet_options = Hash["A", "+103-53", "B", "+103-31", "C", "+103-9", "D", "+103+13", "E", "+103+35", "F", "+103+56", "G", "+103+78"]
    fuel = variant.tire_fuel_consumption.name
    wet = variant.tire_wet_grip.name
    noise_db = variant.tire_rolling_noise_db
    noise_wave = variant.tire_rolling_noise_wave
    image = MiniMagick::Image.open(imagen.attachment.path(:ceelabel))
    result = image.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/#{fuel.downcase}.png"), "png") do |c|
      c.gravity "center"
      c.geometry @fuel_options[fuel]
    end
    result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/#{wet.downcase}.png", "png")) do |c|
      c.gravity "center"
      c.geometry @wet_options[wet]
    end
    result = result.composite(MiniMagick::Image.open("#{Rails.root}/app/assets/images/emision_ruido_#{noise_wave}.png", "png")) do |c|
      c.gravity "center"
      c.geometry "-30+165"
    end
    result.combine_options do |c|
      c.gravity "center"
      c.pointsize '30'
      c.draw "text 60,168 '#{noise_db}'"
      c.font 'arial'
      c.fill "#FFFFFF"
    end
    result.write(imagen.attachment.path(:ceelabel))
  end
end
