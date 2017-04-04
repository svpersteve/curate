class RemoveChatroomTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :chatroom_users
    drop_table :chatrooms
  end
end
