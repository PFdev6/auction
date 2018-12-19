class AddCurrentBargainIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :current_bargain, foreign_key: true
  end
end
