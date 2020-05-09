module UserAPI
  module Types
    class FeedType < Types::BaseObject
      field :id, Integer, null: false
      field :token, String, null: false
      field :name, String, null: false
      field :rss_url, String, null: false
    end
  end
end
