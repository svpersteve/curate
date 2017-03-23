class AddFeaturedContentToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :featured_image, :string
    add_column :posts, :featured_image_uuid, :string
    add_column :posts, :introduction, :text
  end
end
