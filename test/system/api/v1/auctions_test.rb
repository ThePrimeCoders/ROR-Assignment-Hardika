require "application_system_test_case"

class Api::V1::AuctionsTest < ApplicationSystemTestCase
  setup do
    @api_v1_auction = api_v1_auctions(:one)
  end

  test "visiting the index" do
    visit api_v1_auctions_url
    assert_selector "h1", text: "Api/V1/Auctions"
  end

  test "creating a Auction" do
    visit api_v1_auctions_url
    click_on "New Api/V1/Auction"

    click_on "Create Auction"

    assert_text "Auction was successfully created"
    click_on "Back"
  end

  test "updating a Auction" do
    visit api_v1_auctions_url
    click_on "Edit", match: :first

    click_on "Update Auction"

    assert_text "Auction was successfully updated"
    click_on "Back"
  end

  test "destroying a Auction" do
    visit api_v1_auctions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Auction was successfully destroyed"
  end
end
