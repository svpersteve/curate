class AddAuthProviderProfileImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_provider_profile_image, :string, null: true, default: ''
  end
end
