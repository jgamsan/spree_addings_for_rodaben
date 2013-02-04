class Spree::TireSetting < ActiveRecord::Base
  attr_accessor :image, :tyre, :tires_massive, :width, :green_rate
  attr_accessible :image, :tyre, :tires_massive, :width, :green_rate
end
