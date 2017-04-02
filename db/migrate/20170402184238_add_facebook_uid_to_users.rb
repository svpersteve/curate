class AddFacebookUidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_uid, :string
  end
end
