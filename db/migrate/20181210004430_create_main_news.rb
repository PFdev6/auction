class CreateMainNews < ActiveRecord::Migration[5.2]
  def change
    create_table :main_news do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
