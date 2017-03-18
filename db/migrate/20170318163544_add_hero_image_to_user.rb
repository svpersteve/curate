class AddHeroImageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hero_image, :string
    add_column :users, :hero_image_uuid, :string
  end
end
