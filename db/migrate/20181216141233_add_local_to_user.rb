class AddLocalToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :local, :string
  end
end
