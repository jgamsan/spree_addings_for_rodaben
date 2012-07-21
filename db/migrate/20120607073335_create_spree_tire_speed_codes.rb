class CreateSpreeTireSpeedCodes < ActiveRecord::Migration
  def change
    create_table :spree_tire_speed_codes do |t|
      t.string :name

      t.timestamps
    end
    file = "#{Rails.root}/db/datas/vel.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Spree::TireSpeedCode.create(:name => row[0])
    end 
  end
end
