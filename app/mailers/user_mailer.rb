class UserMailer < ApplicationMailer
	def win_bid_notification(auction_bid, user)
		@auction_bid = auction_bid
		@user = user
		email = @user.email
		mail(from: "<info@primecoders.com>", to: email, subject: 'Win Bid Notification')
	end

	def higher_bid_notification(auction_bid, user)
		@auction_bid = auction_bid
		@user = user
		email = @user.email
		mail(from: "<info@primecoders.com>", to: email, subject: 'Higher Bid Notification')
	end
end
