class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :post_code
      t.string :address
      t.integer :payment_method
      t.string :name
      t.integer :status, default: 0
      t.integer :total_payment
      t.integer :shipping_cost

      t.timestamps
    end
  end
end
