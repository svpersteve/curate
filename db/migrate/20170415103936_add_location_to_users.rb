class AddLocationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :country_number, :integer, references: :country
    add_column :users, :city, :string
  end
end
