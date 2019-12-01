class AddUserIdToZone < ActiveRecord::Migration[6.0]
  def change
    add_reference :zones, :user, index: true
  end
end
