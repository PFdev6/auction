class AddUserIdToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :user_id, :integer
  end
end
