class CreateArtworkLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :artwork_likes do |t|
      t.references :user, null: false, index: true
      t.references :artwork, null: false, index: true

      t.timestamps null: false
    end
  end
end
