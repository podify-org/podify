module UserAPI
  class Mutations::OrderFeeds < Mutations::BaseMutation
    null true

    argument :feed_ids, [Integer], required: true

    field :feeds, [Types::FeedType], null: false

    include Podify::Import[
      order_feeds: 'feeds.order',
    ]

    def resolve(feed_ids:)
      feeds = order_feeds.call(user: context[:current_user], feed_ids: feed_ids).value!
      { feeds: FeedPresenter.wrap_all(feeds) }
    end
  end
end
