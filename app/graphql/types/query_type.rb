module Types
  class QueryType < Types::BaseObject
    field :requests, [RequestType], description: 'All requests of the current user', null: false
    def requests
      context[:current_user].requests
    end
  end
end
