class CreateDnsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :dns_records do |t|
      t.references :zone
      t.integer :record_type
      t.text :name
      t.text :value
      t.integer :ttl

      t.timestamps
    end
  end
end
