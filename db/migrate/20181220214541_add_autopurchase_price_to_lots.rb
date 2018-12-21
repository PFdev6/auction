class AddAutopurchasePriceToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :autopurchase_price, :decimal
  end
end
