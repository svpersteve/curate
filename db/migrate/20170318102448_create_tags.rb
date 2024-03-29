class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.text :description
      t.references :creator, references: :users

      t.timestamps null: false
    end
  end
end
