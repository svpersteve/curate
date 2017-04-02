class AddStripeUidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_uid, :string
  end
end
