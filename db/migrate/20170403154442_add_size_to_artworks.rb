class AddSizeToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :frame_size, :string, default: '18-32"', null: false
  end
end
