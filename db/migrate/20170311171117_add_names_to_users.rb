class AddNamesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :full_name, :string, default: '', null: false
    add_column :users, :first_name, :string, default: '', null: false
    add_column :users, :last_name, :string, default: '', null: false
  end
end
