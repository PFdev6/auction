class ChangeColumnNaneInLotFilter < ActiveRecord::Migration[5.2]
  def change
    rename_column :filter_lots, :new, :new_lots
  end
end
