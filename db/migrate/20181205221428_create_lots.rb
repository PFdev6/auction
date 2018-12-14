class CreateLots < ActiveRecord::Migration[5.2]
  def change
    create_table :lots do |t|
      t.string :name
      t.text :description
      t.decimal :start_price
      t.attachment :main_image
      t.datetime :lot_end_date

      t.timestamps
    end
  end
end
