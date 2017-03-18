class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :fan, references: :user, null: false
      t.references :post

      t.timestamps null: false
    end
  end
end
