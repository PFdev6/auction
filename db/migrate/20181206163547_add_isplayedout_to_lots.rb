class AddinprocessToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :inprocess, :boolean, :default => true
  end
end
