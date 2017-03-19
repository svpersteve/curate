class CreateArtistFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_follows do |t|
      t.references :follower, references: :user, null: false
      t.references :artist, references: :user

      t.timestamps null: false
    end
    add_index :artist_follows, [:follower_id, :artist_id], unique: true
  end
end
