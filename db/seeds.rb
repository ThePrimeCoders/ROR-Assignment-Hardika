# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin_user_flag: true, first_name: 'Admin', last_name: 'Super')

# auction create
auctions = Auction.create([{ name: 'Books', auction_time: (Date.today + 10.days), user_id: User.admin_user_flag.first.id }])

# auction_items create
auctions.each do |auction|
	auction.auction_items.create([{name: "Ruby on Rails", min_bid_value: 45}, {name: "DataBase", min_bid_value: 50}])
end

