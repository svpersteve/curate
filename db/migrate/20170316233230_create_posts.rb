class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.references :author, references: :users

      t.timestamps null: false
    end
  end
end
