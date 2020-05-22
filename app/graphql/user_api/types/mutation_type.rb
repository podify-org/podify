module UserAPI
  module Types
    class MutationType < Types::BaseObject
      field :request_for_url, mutation: Mutations::RequestForUrl
      field :destroy_request, mutation: Mutations::DestroyRequest
      field :create_feed, mutation: Mutations::CreateFeed
    end
  end
end
