class CreateWebhooks < ActiveRecord::Migration[8.0]
  def change
  create_table :webhooks do |t|
  t.references :organization, null: false, foreign_key: true
  t.references :feed, foreign_key: true
  t.string :url, null: false
  t.string :secret
  t.string :events, array: true, default: []
  t.timestamps
  end
  end
  end