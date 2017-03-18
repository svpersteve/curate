class CreatePostTags < ActiveRecord::Migration[5.0]
  def change
    create_table :post_tags do |t|
      t.references :post, null: false
      t.references :tag, null: false

      t.timestamps null: false
    end
  end
end
