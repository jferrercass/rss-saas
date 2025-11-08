class CreateFeeds < ActiveRecord::Migration[8.0]
  def change
  create_table :feeds do |t|
  t.references :organization, null: false, foreign_key: true
  t.string :url, null: false
  t.integer :status, default: 0
  t.integer :refresh_interval, default: 60 # minutes
  t.jsonb :parser_settings, default: {}
  t.datetime :last_fetched_at
  t.timestamps
  end
  
  
  add_index :feeds, :url
  end
  end