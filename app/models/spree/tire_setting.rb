class Spree::TireSetting < ActiveRecord::Base
  attr_accessor :image, :tyre
  attr_accessible :image, :tyre
end
