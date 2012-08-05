class AddFieldToSpreeTireInnertubes < ActiveRecord::Migration
  def change
    add_column :spree_tire_innertubes, :sale_price, :decimal, :precision => 6, :scale => 2, :default => 0.00
  end
end
