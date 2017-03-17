class RemoveNullConstraintFromUserSlug < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :slug
    add_column :users, :slug, :string
  end

  def down
    add_column :users, :slug, :string, null: false, default: ''
  end
end
