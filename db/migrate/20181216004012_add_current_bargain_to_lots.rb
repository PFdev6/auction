class AddCurrentBargainToLots < ActiveRecord::Migration[5.2]
  def change
    add_reference :lots, :current_bargain, foreign_key: true
  end
end
