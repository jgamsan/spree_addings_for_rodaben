class Spree::TireLoadCode < ActiveRecord::Base
  attr_accessible :name, :weight
  has_many :variants, :class_name => "Spree::Variant"

  def show_info
    name + " => " + weight
  end
end
