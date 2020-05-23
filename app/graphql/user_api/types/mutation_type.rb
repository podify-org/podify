module UserAPI
  module Types
    class MutationType < Types::BaseObject
      field :request_for_url, mutation: Mutations::RequestForUrl
      field :update_request, mutation: Mutations::UpdateRequest
      field :destroy_request, mutation: Mutations::DestroyRequest
      field :create_feed, mutation: Mutations::CreateFeed
      field :destroy_feed, mutation: Mutations::DestroyFeed
    end
  end
end
