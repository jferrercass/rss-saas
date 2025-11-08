class CreateItems < ActiveRecord::Migration[8.0]
  def change
  create_table :items do |t|
  t.references :feed, null: false, foreign_key: true
  t.string :guid, null: false
  t.string :title
  t.string :link
  t.text :content
  t.datetime :published_at
  t.datetime :fetched_at
  t.string :hash
  t.timestamps
  end
  
  
  add_index :items, [:feed_id, :guid], unique: true
  add_index :items, :published_at
  end
  end