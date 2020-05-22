module Feeds
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      destroy_request: 'requests.destroy',
    ]

    def call(feed)
      DB.transaction do
        yield destroy_requests(feed.requests)
        feed.destroy
      end
      events.publish('feeds.destroyed', feed: feed)
      Success()
    end

    def destroy_requests(requests)
      requests.each do |request|
        yield destroy_request.call(request)
      end
      Success()
    end
  end
end
