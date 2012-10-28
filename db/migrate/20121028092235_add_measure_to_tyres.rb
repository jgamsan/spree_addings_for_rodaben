class AddMeasureToTyres < ActiveRecord::Migration
  def change
  add_column :spree_tire_widths, :is_mm, :boolean, :default => true
  add_column :spree_tire_serials, :is_mm, :boolean, :default => true
  add_column :spree_tire_innertubes, :is_mm, :boolean, :default => true
  end
end
