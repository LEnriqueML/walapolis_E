class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :show_email, :boolean, default: true
    add_column :users, :show_phone, :boolean, default: false
  end
end
