class CreateArtwork < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.string :name, null: false
      t.references :artist, references: :users, index: true
      t.text :description
      t.string :image
      t.string :image_uuid
      t.string :slug
    end
  end
end
