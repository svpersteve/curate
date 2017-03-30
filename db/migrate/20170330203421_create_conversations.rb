class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.references :sender, references: :users
      t.references :recipient, references: :users
      t.timestamps
    end
  end
end
