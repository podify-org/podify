module UserAPI
  class Mutations::UpdateRequest < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true
    argument :feed_id, Integer, required: true

    field :errors, [String], null: false
    field :request, Types::RequestType, null: true

    include Dry::Monads[:result]
    include Podify::Import[
      update_request: 'requests.update',
    ]

    def resolve(id:, feed_id:)
      request = context[:current_user].requests_dataset[id]
      return { errors: ['Request does not exist'] } unless request

      case update_request.call(request, feed_id: feed_id)
      in Success()
        {
          errors: [],
          request: RequestPresenter.wrap(request),
        }
      in Failure(failure)
        {
          errors: [failure.to_s],
        }
      end
    end
  end
end
