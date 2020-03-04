class Api::V1::AuctionItemBidsController < Api::V1::ApplicationController
	before_action :authentication_request!
	before_action :set_auction
	before_action :set_auction_item
	before_action :set_auction_item_bid, only: [:edit, :show, :update]

	def index
		@auction_item_bids = @auction_item.auction_bids
		render json: @auction_item_bids.as_json
	end

	# see current auction live bid price

	def bid_lists
		auction_item_bids = @auction.auction_item_bids.where(user_id: current_user.id)
		render json: @auction_item_bids.as_json
	end

	# see highest bid price 
	def highest_bids
		bid_data = @auction_item.auction_item_bids.max(:bid_value)
		data_json = {highest_bid_price: bid_data}
		render json: data_json
	end

	def show
		render json: @auction_item_bid.as_json
	end

	def new
		@auction_item_bid = AuctionItemBid.new
		render json: @auction_item_bid.as_json
	end

	# place bid

	def create
		params[:auction_item_bid][:user_id] = current_user.id
		params[:auction_item_bid][:auction_id] = params[:auction_id]
		@auction_item_bid = @auction_item.auction_item_bids.new(auction_item_bid_params)
		if @auction_item_bid.save
			SendHigherBidToUserWorker.perform_at(1.minutes.from_now, @auction, @auction_item_bid)
			render json: @auction_item_bid.as_json, status: :created
		else
			render json: { errors: @auction_item_bid.errors }, status: :unprocessable_entity
		end
	end

	def edit
		render json: @auction_item_bid.as_json
	end

	# update bids
	def update
		@auction_item_bid = AuctionItemBid.update(auction_item_bid_params)
		if @auction_item_bid.save
			render json: @auction_item_bid.as_json, status: :updated
		else
			render json: { errors: @auction_item_bid.errors }, status: :unprocessable_entity
		end
	end

	private

	def auction_item_bid_params
		params.require(:auction_item_bid).permit(:bid_value, :auction_item_id, :user_id, :auction_id)
	end

  	def set_auction_item_bid
    	@auction_item_bid = @auction_item.find_by!(id: params[:id])
    	render json: :not_found if @auction_item_bid.blank?
  	end
end
