module UserAPI
  class Mutations::RequestForUrl < Mutations::BaseMutation
    null true

    argument :url, String, required: true

    field :request, Types::RequestType, null: true
    field :errors, [String], null: false

    include Dry::Monads[:result]
    include Dry::Effects::Handler.Defer
    include Podify::Import[
      create_request_for_url: 'requests.create_for_url',
    ]

    def resolve(url:)
      result = with_defer do
        create_request_for_url.call(user: context[:current_user], url: url)
      end

      case result
      in Success(request)
        {
          request: RequestPresenter.new(request),
          errors: [],
        }
      in Failure(failure)
        {
          request: nil,
          errors: [failure.to_s]
        }
      end
    end
  end
end
