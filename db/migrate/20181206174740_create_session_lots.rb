class CreateSessionLots < ActiveRecord::Migration[5.2]
  def change
    create_table :session_lots do |t|
      t.belongs_to :user, foreign_key: true
      t.decimal :current_price
      t.integer :id_user_winner

      t.timestamps
    end
  end
end
