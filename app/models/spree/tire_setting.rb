class Spree::TireSetting < ActiveRecord::Base
  attr_accessor :image, :tyre, :tires_massive, :width
  attr_accessible :image, :tyre, :tires_massive, :width
end
