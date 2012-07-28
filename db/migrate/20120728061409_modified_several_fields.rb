class ModifiedSeveralFields < ActiveRecord::Migration
  def up
    change_column :spree_variants, :tire_gr, :boolean
    change_column :spree_variants, :tire_rf, :boolean
  end

  def down
    change_column :spree_variants, :tire_gr, :integer
    change_column :spree_variants, :tire_rf, :integer
  end
end
