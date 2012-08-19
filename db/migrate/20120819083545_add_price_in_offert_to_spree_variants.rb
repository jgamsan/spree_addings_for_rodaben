class AddPriceInOffertToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :price_in_offert, :decimal, :precision => 8, :scale => 2, :default => 0.00
    add_column :spree_products, :show_in_offert, :boolean, :default => false
  end
end
