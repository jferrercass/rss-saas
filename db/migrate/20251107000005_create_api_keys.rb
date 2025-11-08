class CreateApiKeys < ActiveRecord::Migration[8.0]
  def change
  create_table :api_keys do |t|
  t.references :organization, null: false, foreign_key: true
  t.string :key
  t.string :scopes, array: true, default: []
  t.integer :rate_limit, default: 1000
  t.timestamps
  end
  
  
  add_index :api_keys, :key, unique: true
  end
  end