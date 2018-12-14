class AddReflotToSessionLots < ActiveRecord::Migration[5.2]
  def change
    add_reference :session_lots, :lot, foreign_key: true
  end
end
