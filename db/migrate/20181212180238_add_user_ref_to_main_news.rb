class AddUserRefToMainNews < ActiveRecord::Migration[5.2]
  def change
    add_reference :main_news, :user, foreign_key: true
  end
end
