class AddNewLotToFilter < ActiveRecord::Migration[5.2]
  def change
    add_column :filter_lots, :new, :boolean
  end
end
