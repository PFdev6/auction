class AddCurrentBargainsToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :current_bargain, foreign_key: true
  end
end
