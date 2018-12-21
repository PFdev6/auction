class AddPlayedOutToCurrentBargains < ActiveRecord::Migration[5.2]
  def change
    add_column :current_bargains, :played_out, :boolean, default: false
  end
end
