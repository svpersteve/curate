class AddConversationToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :conversation_id, :integer, references: :conversation, index: true
    add_column :messages, :read, :boolean, default: false
  end
end
