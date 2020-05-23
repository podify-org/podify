module Feeds
  class Order
    include Dry::Monads[:result, :do]

    def call(user:, feed_ids:)
      feeds = get_ordered_feeds(dataset: user.feeds_dataset, feed_ids: feed_ids)
      update_positions(feeds)
      Success(feeds)
    end

    def get_ordered_feeds(dataset:, feed_ids:)
      feeds_by_id = dataset
        .where(id: feed_ids)
        .all
        .group_by(&:id)
      feed_ids.flat_map { |id| feeds_by_id[id] || [] }
    end

    def update_positions(feeds)
      feeds.each_with_index do |feed, index|
        feed.update(position: index)
      end
    end
  end
end
