class Api::V1::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authentication_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

	def set_auction
		params[:auction_id] = params[:auction_id].present? ? params[:auction_id] : params[:id]
  	@auction = Auction.disabled.find_by(id: params[:auction_id])
  	render json: :not_found if @auction.blank?
	end

	def set_auction_item
		params[:auction_item_id] = params[:auction_item_id].present? ? params[:auction_item_id] : params[:id]
  	@auction_item = @auction.auction_items.find_by(id: params[:auction_item_id])
  	render json: :not_found if @auction_item.blank?
	end

  private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end