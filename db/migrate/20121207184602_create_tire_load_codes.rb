class CreateTireLoadCodes < ActiveRecord::Migration
  def change
    create_table :tire_load_codes do |t|
      t.string :name
      t.decimal :weight, :precision => 6, :scale => 2, :default => 0.00
      t.timestamps
    end
    add_column :spree_variants, :tire_load_code_id, :integer, :after => :tire_innertube_id
    add_column :spree_variants, :tire_position, :integer, :after => :tire_speed_code_id
  end
end
