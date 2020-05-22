module UserAPI
  class Mutations::DestroyFeed < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true

    field :errors, [String], null: false

    include Dry::Monads[:result]
    include Podify::Import[
      destroy_feed: 'feeds.destroy',
    ]

    def resolve(id:)
      feed = Feed[id]
      return { errors: ['Feed does not exist'] } unless feed

      case destroy_feed.call(feed)
        in Success()
        {
          errors: [],
        }
        in Failure(failure)
        {
          errors: [failure.to_s]
        }
      end
    end
  end
end
