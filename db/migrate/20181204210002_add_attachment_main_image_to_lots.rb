class AddAttachmentMainImageToLots < ActiveRecord::Migration[5.2]
  def self.up
    change_table :lots do |t|
      t.attachment :main_image
    end
  end

  def self.down
    remove_attachment :lots, :main_image
  end
end
