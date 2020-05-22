module Requests
  class CreateForUrl
    include Dry::Monads[:result, :do, :maybe]

    include Podify::Import[
      create_request: 'requests.create',
      find_or_create_source: 'sources.find_or_create',
    ]

    def call(user:, feed:, url:)
      DB.transaction do
        source = yield find_or_create_source.call(url)
        request = yield create_request.call(user_id: user.id, source_id: source.id, feed_id: feed.id)
        Success(request)
      end
    end
  end
end
