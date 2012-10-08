class AddWorkshopIdToSpreeOrders < ActiveRecord::Migration
  def change
  add_column :spree_orders, :workshop_id, :integer, :default => nil
  end
end
