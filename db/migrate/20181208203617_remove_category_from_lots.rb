class RemoveCategoryFromLots < ActiveRecord::Migration[5.2]
  def change
    remove_column :lots, :category
  end
end
