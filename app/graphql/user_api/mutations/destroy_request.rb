module UserAPI
  class Mutations::DestroyRequest < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true

    field :errors, [String], null: false

    include Dry::Monads[:result]
    include Podify::Import[
      destroy_request: 'requests.destroy',
    ]

    def resolve(id:)
      request = context[:current_user].requests_dataset[id]
      return { errors: ['Request does not exist'] } unless request

      case destroy_request.call(request)
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
