desc 'Win Bid Notification'
task win_bid_notifiction: :environment do
	time = Time.now
	auction_data = Auction.disabled.where("auction_time < ?", time)
	if auction_data.present?
	    auction_data.each do |auction|
	    	auction_bid = auction.winner_list
	    	if auction_bid.present?
	    		UserMailer.win_bid_notification(bid, bid.user, auction).deliver_now
	    		auction.update(disable: true)
	  		end
	  	end
	end
end