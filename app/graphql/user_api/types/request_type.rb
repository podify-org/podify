module UserAPI
  module Types
    class RequestType < Types::BaseObject
      field :id, Integer, null: false
      field :source, Types::SourceType, null: true
    end
  end
end
