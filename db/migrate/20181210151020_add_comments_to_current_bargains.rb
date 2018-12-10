class AddCommentsToCurrentBargains < ActiveRecord::Migration[5.2]
  def change
    add_reference :current_bargains, :comment, foreign_key: true
  end
end
