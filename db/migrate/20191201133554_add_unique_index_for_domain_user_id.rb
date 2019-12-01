class AddUniqueIndexForDomainUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :zones, [:name, :user_id], unique: true
  end
end
