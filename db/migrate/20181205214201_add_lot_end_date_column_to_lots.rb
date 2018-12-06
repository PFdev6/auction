class AddLotEndDateColumnToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :lot_end_date, :datetime
  end
end
