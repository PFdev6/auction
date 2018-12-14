class AddImgsToLots < ActiveRecord::Migration[5.2]
  def change
    add_attachment :lots, :first_additional_image
    add_attachment :lots, :second_additional_image
  end
end
