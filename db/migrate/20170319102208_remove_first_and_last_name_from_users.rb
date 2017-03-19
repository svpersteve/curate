class RemoveFirstAndLastNameFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
