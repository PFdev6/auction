class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :lots, :inprocess, :inprocess
  end
end
