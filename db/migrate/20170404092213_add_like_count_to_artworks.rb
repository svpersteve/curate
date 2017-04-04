class AddLikeCountToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :artwork_likes_count, :integer, default: 0
  end
end
