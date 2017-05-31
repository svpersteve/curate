class AddTagsToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :tags, :text
  end
end
