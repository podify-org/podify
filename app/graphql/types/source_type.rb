module Types
  class SourceType < Types::BaseObject
    field :id, Integer, null: false
    field :url, String, null: false
    field :downloads, [Types::DownloadType], null: false
  end
end
