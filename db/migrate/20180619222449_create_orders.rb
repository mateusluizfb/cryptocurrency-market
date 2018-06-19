class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :owner_email
      t.string :coin_name
      t.decimal :coin_amount

      t.timestamps
    end
  end
end
