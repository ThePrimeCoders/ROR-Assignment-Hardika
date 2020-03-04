class SendHigherBidToUserWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  def perform(*args)
    # Do something
  end
end
