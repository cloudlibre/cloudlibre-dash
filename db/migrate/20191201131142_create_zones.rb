class CreateZones < ActiveRecord::Migration[6.0]
  def change
    create_table :zones do |t|
      t.text :name

      t.timestamps
    end
  end
end
