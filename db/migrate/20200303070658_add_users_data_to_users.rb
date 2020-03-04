class AddUsersDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin_user_flag, :boolean, default: false
    add_column :users, :phone, :string
  end
end
