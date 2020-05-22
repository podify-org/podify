module Feeds
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      destroy_request: 'requests.destroy',
    ]

    def call(feed)
      yield ensure_may_destroy(feed)
      DB.transaction do
        yield destroy_requests(feed.requests)
        feed.destroy
      end
      events.publish('feeds.destroyed', feed: feed)
      Success()
    end

    def ensure_may_destroy(feed)
      if feed.type == 'all'
        Failure('feeds.destroy.special_feed')
      else
        Success()
      end
    end

    def destroy_requests(requests)
      requests.each do |request|
        yield destroy_request.call(request)
      end
      Success()
    end
  end
end
