Spree::Product.class_eval do
  attr_accessible :tire_speed_code_id, :tire_rf, :tire_innertube_id, :tire_width_id,
                  :tire_serial_id, :tire_gr, :tire_season
  attr_accessible :count_on_hand

  delegate_belongs_to :master, :tire_width_id, :tire_rf, :tire_innertube_id,
                    :tire_speed_code_id, :tire_serial_id, :tire_gr, :tire_season
                    
  scope :by_width, lambda { |width| joins(:master).where("spree_variants.tire_width_id = ?", width)}
  scope :by_serial, lambda { |serial| joins(:master).where("spree_variants.tire_serial_id = ?", serial)}
  scope :by_innertube, lambda { |innertube| joins(:master).where("spree_variants.tire_innertube_id = ?", innertube)}
  scope :by_gr, lambda { |gr| joins(:master).where("spree_variants.tire_gr = ?", gr) }
  scope :by_speed, lambda { |speed| joins(:master).where("spree_variants.tire_speed_code_id = ?", speed)}
  scope :by_rf, lambda { |rf| joins(:master).where("spree_variants.tire_rf = ?", rf)}
  scope :by_season, lambda { |season| joins(:master).where("spree_variants.tire_season = ?", season)}
end
