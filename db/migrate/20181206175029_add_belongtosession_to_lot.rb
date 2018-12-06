class AddBelongtosessionToLot < ActiveRecord::Migration[5.2]
  def change
    add_reference :lots, :session_lot, foreign_key: true
  end
end
