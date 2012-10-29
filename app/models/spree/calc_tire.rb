class Spree::CalcTire < ActiveRecord::Base
  attr_accessor :width, :serial, :innertube
  attr_accessible :width, :serial, :innertube
end
