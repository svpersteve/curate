class AddSocialLinksToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_username, :string, default: ''
    add_column :users, :twitter_username, :string, default: ''
    add_column :users, :website, :string, default: ''
  end
end
