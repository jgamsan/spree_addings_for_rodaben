class CreateTireLoadCodes < ActiveRecord::Migration
  def change
    create_table :tire_load_codes do |t|

      t.timestamps
    end
  end
end
