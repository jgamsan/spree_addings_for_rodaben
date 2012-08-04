class ChangeCsvFiles < ActiveRecord::Migration
  def up
  end
  execute "truncate table spree_tire_widths"
  execute "truncate table spree_tire_serials"
  execute "truncate table spree_tire_innertubes"
  execute "truncate table spree_tire_speed_codes"
  execute "ALTER SEQUENCE spree_tire_innertubes_id_seq RESTART WITH 1"
  execute "ALTER SEQUENCE spree_tire_serials_id_seq RESTART WITH 1"
  execute "ALTER SEQUENCE spree_tire_speed_codes_id_seq RESTART WITH 1"
  execute "ALTER SEQUENCE spree_tire_widths_id_seq RESTART WITH 1"
  def down
  end
end
