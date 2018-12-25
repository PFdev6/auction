class CreateFilterLots < ActiveRecord::Migration[5.2]
  def change
    create_table :filter_lots do |t|
      t.string :user_name
      t.decimal :autopurchase_price
      t.decimal :start_price
      t.boolean :played_out
      t.timestamps
    end
  end
end
