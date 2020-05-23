module Requests
  class Update
    include Dry::Monads[:result, :maybe, :do]

    include Podify::Import[
      'events',
      'requests.contract',
    ]

    def call(request, feed_id:)
      feed = yield get_feed(request, feed_id)
      request.update(feed_id: feed.id)
      events.publish('requests.updated', request: request)
      Success()
    end

    def get_feed(request, feed_id)
      Maybe(request.user.feeds_dataset[feed_id]).or(
        Failure('requests.update.feed_not_found')
      )
    end
  end
end
