class AddTimesToArtworks < ActiveRecord::Migration[5.0]
  def change
    Artwork.all.each do |a|
      a.created_at = Time.now
      a.updated_at = Time.now
      a.save
    end
  end
end
