class AddIsplayedoutToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :isplayedout, :boolean
  end
end
