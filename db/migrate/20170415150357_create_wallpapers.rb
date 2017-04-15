class CreateWallpapers < ActiveRecord::Migration[5.0]
  def change
    create_table :wallpapers do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :image_uuid, null: false
      t.string :slug
      t.string :location

      t.timestamps null: false
    end
  end
end
