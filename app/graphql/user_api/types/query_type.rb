module UserAPI
  module Types
    class QueryType < Types::BaseObject
      field :data, DataType, description: 'All requests of the current user', null: false
      def data
        OpenStruct.new(
          requests: context[:current_user].requests_dataset.order { created_at.desc }.all.map do |request|
            RequestPresenter.new(request)
          end,
          feeds: [context[:current_user].all_feed].map do |feed|
            FeedPresenter.new(feed)
          end
        )
      end

      field :requests, [RequestType], description: 'All requests of the current user', null: false
      def requests
        context[:current_user].requests_dataset.order { created_at.desc }.all.map do |request|
          RequestPresenter.new(request)
        end
      end

      field :source, SourceType, description: 'A source requested by the user', null: false do
        argument :id, Integer, required: true
      end
      def source(id:)
        SourcePresenter.new(context[:current_user].sources_dataset.with_pk!(id))
      end
    end
  end
end
