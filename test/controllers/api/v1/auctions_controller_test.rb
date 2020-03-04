require 'test_helper'

class Api::V1::AuctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_auction = api_v1_auctions(:one)
  end

  test "should get index" do
    get api_v1_auctions_url
    assert_response :success
  end

  test "should get new" do
    get new_api_v1_auction_url
    assert_response :success
  end

  test "should create api_v1_auction" do
    assert_difference('Api::V1::Auction.count') do
      post api_v1_auctions_url, params: { api_v1_auction: {  } }
    end

    assert_redirected_to api_v1_auction_url(Api::V1::Auction.last)
  end

  test "should show api_v1_auction" do
    get api_v1_auction_url(@api_v1_auction)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_v1_auction_url(@api_v1_auction)
    assert_response :success
  end

  test "should update api_v1_auction" do
    patch api_v1_auction_url(@api_v1_auction), params: { api_v1_auction: {  } }
    assert_redirected_to api_v1_auction_url(@api_v1_auction)
  end

  test "should destroy api_v1_auction" do
    assert_difference('Api::V1::Auction.count', -1) do
      delete api_v1_auction_url(@api_v1_auction)
    end

    assert_redirected_to api_v1_auctions_url
  end
end
