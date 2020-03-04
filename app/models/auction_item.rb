class AuctionItem < ApplicationRecord
  belongs_to :auction
  has_many :auction_item_bids, dependent: :destroy

  validates :auction, presence: true
  validates :min_bid_value, presence: true
  validates :name, presence: true

end
