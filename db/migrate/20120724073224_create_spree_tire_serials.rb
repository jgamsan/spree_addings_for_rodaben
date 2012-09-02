class CreateSpreeTireSerials < ActiveRecord::Migration
  def change
    create_table :spree_tire_serials do |t|
      t.string :name

      t.timestamps
    end
  end
end
