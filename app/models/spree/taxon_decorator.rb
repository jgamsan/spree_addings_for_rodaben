Spree::Taxon.class_eval do
  scope :by_car,
    joins(:products).where("spree_products.id IN (SELECT spree_products.id FROM spree_products INNER JOIN spree_products_taxons ON spree_products_taxons.product_id = spree_products.id INNER JOIN spree_taxons ON spree_taxons.id = spree_products_taxons.taxon_id WHERE (spree_taxons.id IN (4, 5, 6, 7, 8))) and spree_taxons.parent_id =  2").order("spree_taxons.name").group("spree_taxons.id")

  scope :by_moto,
    joins(:products).where("spree_products.id IN (SELECT spree_products.id FROM spree_products INNER JOIN spree_products_taxons ON spree_products_taxons.product_id = spree_products.id INNER JOIN spree_taxons ON spree_taxons.id = spree_products_taxons.taxon_id WHERE (spree_taxons.id = 9)) and spree_taxons.parent_id =  2").order("spree_taxons.name").group("spree_taxons.id")
end
