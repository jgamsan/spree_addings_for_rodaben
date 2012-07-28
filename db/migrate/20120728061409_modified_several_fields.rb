class ModifiedSeveralFields < ActiveRecord::Migration
  def up
    remove_column :spree_variants, :tire_gr
    remove_column :spree_variants, :tire_rf
    add_column :spree_variants, :tire_gr, :boolean
    add_column :spree_variants, :tire_rf, :boolean
  end

  def down
    
  end
end
