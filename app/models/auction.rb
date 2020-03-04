class Auction < ApplicationRecord
  belongs_to :user
  has_many :auction_items, dependent: :destroy
  has_many :auction_item_bids, dependent: :destroy

  validates :name, presence: true
  validates :auction_time, presence: true
  validates :user, presence: true

  scope :disabled, -> { where(disable: false) }

  # daily check winner list
  def winner_list
    data = []
    self.auction_items.each do |auction_item|
      auction_data = auction_item.auction_bids
      data << auction_item.auction_bids.where(amount: auction_data.maximum(:amount)).first
    end
    return data
  end
  
end
