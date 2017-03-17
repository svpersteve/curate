class AddFeaturedStateToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :featured, :boolean, default: false
  end
end
