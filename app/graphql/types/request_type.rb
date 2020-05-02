module Types
  class RequestType < Types::BaseObject
    field :source, Types::SourceType, null: true
  end
end
