module UserAPI
  module Types
    class RequestType < Types::BaseObject
      field :id, Integer, null: false
      field :source, Types::SourceType, null: true
      field :feed_id, Integer, null: false
      field :feed, Types::FeedType, null: false
    end
  end
end
