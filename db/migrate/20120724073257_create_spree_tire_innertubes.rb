class CreateSpreeTireInnertubes < ActiveRecord::Migration
  def change
    create_table :spree_tire_innertubes do |t|
      t.string :name

      t.timestamps
    end
  end
end
