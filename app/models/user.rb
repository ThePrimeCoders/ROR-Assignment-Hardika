class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :auction_items
  has_many :auctions
  has_many :auction_item_bids


  scope :admin_user_flag, -> { where(admin_user_flag: true) }


  def name
  	"#{first_name} #{last_name}"
  end

end
