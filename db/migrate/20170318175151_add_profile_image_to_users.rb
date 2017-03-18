class AddProfileImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_image, :string
    add_column :users, :profile_image_uuid, :string
  end
end
