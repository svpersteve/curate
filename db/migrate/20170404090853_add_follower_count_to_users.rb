class AddFollowerCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :artist_follows_count, :integer, default: 0
  end
end
