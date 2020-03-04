class CreateAuctionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :auction_items do |t|
      t.string :name
      t.float :min_bid_value
      t.references :auction, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
