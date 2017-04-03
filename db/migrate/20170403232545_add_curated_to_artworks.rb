class AddCuratedToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :curated, :boolean, default: false
  end
end
