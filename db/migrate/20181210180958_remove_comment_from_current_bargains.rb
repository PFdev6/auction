class RemoveCommentFromCurrentBargains < ActiveRecord::Migration[5.2]
  def change
    remove_column :current_bargains, :comment
  end
end
