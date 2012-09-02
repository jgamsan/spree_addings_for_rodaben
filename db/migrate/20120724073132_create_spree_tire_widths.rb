class CreateSpreeTireWidths < ActiveRecord::Migration
  def change
    create_table :spree_tire_widths do |t|
      t.string :name

      t.timestamps
    end
  end
end
