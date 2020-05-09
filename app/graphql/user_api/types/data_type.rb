module UserAPI
  module Types
    class DataType < Types::BaseObject
      field :requests, [RequestType], null: false
      field :feeds, [FeedType], null: false
    end
  end
end
