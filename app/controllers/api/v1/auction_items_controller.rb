class Api::V1::AuctionItemsController < Api::V1::ApplicationController
	before_action :authentication_request!
	before_action :set_auction
	before_action :set_auction_item, only: :show

	# current auction auction items list
	def index
		@auction_items = @auction.auction_items
		render json: @auction_items.as_json
	end

	#see current auction item
	def show
		render json: @auction_item.as_json
	end
end
