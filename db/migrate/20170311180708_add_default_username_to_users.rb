class AddDefaultUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :username, :string, null: false, default: ''
  end
end
