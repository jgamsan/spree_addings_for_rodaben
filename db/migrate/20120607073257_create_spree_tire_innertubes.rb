class CreateSpreeTireInnertubes < ActiveRecord::Migration
  def change
    create_table :spree_tire_innertubes do |t|
      t.string :name

      t.timestamps
    end
    file = "#{Rails.root}/db/datas/llantas.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::TireInnertube.create(:name => row[0])
    end 
  end
end
