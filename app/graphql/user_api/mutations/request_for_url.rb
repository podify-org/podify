module UserAPI
  class Mutations::RequestForUrl < Mutations::BaseMutation
    null true

    argument :url, String, required: true
    argument :feed_id, Integer, required: true

    field :request, Types::RequestType, null: true
    field :errors, [String], null: false

    include Dry::Monads[:result]
    include Dry::Effects::Handler.Defer
    include Podify::Import[
      create_request_for_url: 'requests.create_for_url',
    ]

    def resolve(url:, feed_id:)
      feed = context[:current_user].feeds_dataset[feed_id]
      if feed.nil?
        return {
          request: nil,
          errors: ['Feed does not exist'],
        }
      end

      result = with_defer do
        create_request_for_url.call(user: context[:current_user], feed: feed, url: url)
      end

      case result
      in Success(request)
        {
          request: RequestPresenter.wrap(request),
          errors: [],
        }
      in Failure(failure)
        {
          request: nil,
          errors: [failure.to_s],
        }
      end
    end
  end
end
