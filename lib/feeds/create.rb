module Feeds
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'feeds.contract',
    ]

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      feed = yield create_feed(attrs)
      events.publish('feeds.created', feed: feed)
      Success(feed)
    end

    def create_feed(attrs)
      Success(Feed.create(**attrs, type: 'manual'))
    end
  end
end
