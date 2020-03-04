class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.string :name
      t.datetime :auction_time
      t.boolean :disable, default: false
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
