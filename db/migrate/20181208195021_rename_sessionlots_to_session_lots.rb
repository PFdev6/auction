class RenameSessionlotsToSessionLots < ActiveRecord::Migration[5.2]
  def change
    rename_table :session_lots, :current_bargains
  end
end
