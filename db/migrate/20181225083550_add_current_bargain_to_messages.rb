class AddCurrentBargainToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :current_bargain, index: true
  end
end
