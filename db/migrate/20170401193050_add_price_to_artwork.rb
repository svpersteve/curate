class AddPriceToArtwork < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :price, :integer
  end
end
