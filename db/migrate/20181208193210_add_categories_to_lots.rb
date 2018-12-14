class AddCategoriesToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :category, :string 
  end
end
