class CreateAuctionItemBids < ActiveRecord::Migration[6.0]
  def change
    create_table :auction_item_bids do |t|
      t.float :bid_value
      t.references :auction_item, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true
      t.references :auction, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
