class AddUserinfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :likes, :integer, :default => 0 
    add_column :users, :first_name, :string 
    add_column :users, :second_name, :string 
    add_column :users, :about_users, :text 
 end 
end
