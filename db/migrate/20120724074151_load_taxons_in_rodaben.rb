class LoadTaxonsInRodaben < ActiveRecord::Migration
  def up
    file = "#{Rails.root}/db/datas/taxons.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::Taxon.create(:parent_id => row[0], :name => row[1], :taxonomy_id => row[2])
    end
    file = "#{Rails.root}/db/datas/marcas.csv"
    CSV.foreach(file, :col_sep =>',') do |row|
      Spree::Taxon.create(:parent_id => row[0], :name => row[1].capitalize, :taxonomy_id => row[2])
    end
  end

  def down
  end
end
