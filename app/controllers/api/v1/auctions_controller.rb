class Api::V1::AuctionsController < Api::V1::ApplicationController
  before_action :authentication_request!
	before_action :set_auction, except: :index

	# all auction items
  def index
		@auctions = Auction.disabled
    render json: @auctions.as_json
	end

  # see auction
	def show
		render json: @auction.as_json
	end

end
