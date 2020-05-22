module UserAPI
  class Mutations::CreateFeed < Mutations::BaseMutation
    null true

    argument :name, String, required: true

    field :feed, Types::FeedType, null: true
    field :errors, [String], null: false

    include Dry::Monads[:result]
    include Podify::Import[
      create_feed: 'feeds.create',
    ]

    def resolve(name:)
      case create_feed.call(user_id: context[:current_user].id, name: name)
      in Success(feed)
        {
          feed: FeedPresenter.new(feed),
          errors: [],
        }
      in Failure(failure)
        {
          feed: nil,
          errors: [failure.to_s]
        }
      end
    end
  end
end
