class AuctionItemBid < ApplicationRecord
  belongs_to :auction_item
  belongs_to :user
  belongs_to :auction

  validates :user, presence: true
  validates :auction_item, presence: true
  validates :auction, presence: true
  validates :bid_value, presence: true

  def self.higher_bid_notification(auction, auction_item_bid)
    higher_bids = auction.auction_item_bids.where("auction_item_id = ? and bid_value < ? and user_id != ?", auction_item_bid.auction_item_id, auction_item_bid.bid_value, auction_item_bid.user_id)
    users = higher_bids.map(&:user_id).uniq
    User.where(id: users).each do |user|
      UserMailer.higher_bid_notification(auction_item_bid, user, auction).deliver_now!
    end
  end
end
