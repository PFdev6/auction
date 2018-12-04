class AddImageColumnToLots < ActiveRecord::Migration[5.2]
  def change
    add_column :lots, :main_image, :attachment
  end
end
