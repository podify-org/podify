module Types
  class MutationType < Types::BaseObject
    field :request_for_url, mutation: Mutations::RequestForUrl
  end
end
