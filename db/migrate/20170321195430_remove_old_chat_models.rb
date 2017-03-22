class RemoveOldChatModels < ActiveRecord::Migration[5.0]
  def up
    drop_table :messages
    drop_table :chat_rooms
  end

  def down
    create_table :chat_rooms do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    create_table :messages do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true
    drop_table :chat_rooms
    drop_table :messages
  end
end
