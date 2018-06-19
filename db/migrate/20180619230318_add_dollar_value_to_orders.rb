class AddDollarValueToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :dollar_value, :decimal
  end
end
