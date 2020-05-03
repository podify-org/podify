module UserAPI
  module Types
    class QueryType < Types::BaseObject
      field :requests, [RequestType], description: 'All requests of the current user', null: false
      def requests
        context[:current_user].requests_dataset.order { created_at.desc }.all
      end
    end
  end
end
