class CreateSpreeTireSerials < ActiveRecord::Migration
  def change
    create_table :spree_tire_serials do |t|
      t.string :name

      t.timestamps
    end
    file = "#{Rails.root}/db/datas/rodaben-series.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Spree::TireSerial.create(:name => row[0])
    end 
  end
end
