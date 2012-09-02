class CreateSpreeTireSpeedCodes < ActiveRecord::Migration
  def change
    create_table :spree_tire_speed_codes do |t|
      t.string :name

      t.timestamps
    end
  end
end
