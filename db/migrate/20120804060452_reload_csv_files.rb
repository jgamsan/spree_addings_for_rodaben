class ReloadCsvFiles < ActiveRecord::Migration
  def up
    file = "#{Rails.root}/db/datas/rodaben-taxonomies.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::Taxonomy.create(:name => row[0])
    end
    file = "#{Rails.root}/db/datas/rodaben-taxons.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::Taxon.create(:parent_id => row[0], :name => row[1], :taxonomy_id => row[2])
    end
    file = "#{Rails.root}/db/datas/rodaben-marcas.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::Taxon.create(:parent_id => row[0], :name => row[1].capitalize, :taxonomy_id => row[2])
    end
    file = "#{Rails.root}/db/datas/rodaben-anchos.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Spree::TireWidth.create(:name => row[0])
    end
    file = "#{Rails.root}/db/datas/rodaben-series.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Spree::TireSerial.create(:name => row[0])
    end
    file = "#{Rails.root}/db/datas/rodaben-llantas.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::TireInnertube.create(:name => row[0])
    end
    file = "#{Rails.root}/db/datas/rodaben-ivel.csv"
    CSV.foreach(file, :col_sep =>';') do |row|
      Spree::TireSpeedCode.create(:name => row[0])
    end 
  end

  def down
  end
end
