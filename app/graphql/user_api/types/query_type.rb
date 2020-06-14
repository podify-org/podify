module UserAPI
  module Types
    class QueryType < Types::BaseObject
      field :server_info, ServerInfoType, description: 'Basic info about the server', null: false
      def server_info
        {
          root_url: 'bla'
        }
      end

      field :data, DataType, description: 'All requests of the current user', null: false
      def data
        OpenStruct.new(
          requests: RequestPresenter.wrap_all(
            context[:current_user].requests_dataset.order { created_at.desc }.all
          ),
          feeds: FeedPresenter.wrap_all(
            context[:current_user].feeds_dataset.ordered.all
          ),
        )
      end

      field :requests, [RequestType], description: 'All requests of the current user', null: false
      def requests
        RequestPresenter.wrap_all(
          context[:current_user].requests_dataset.order { created_at.desc }.all
        )
      end

      field :source, SourceType, description: 'A source requested by the user', null: false do
        argument :id, Integer, required: true
      end
      def source(id:)
        SourcePresenter.wrap(context[:current_user].sources_dataset.with_pk!(id))
      end
    end
  end
end
