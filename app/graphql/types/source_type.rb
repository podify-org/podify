module Types
  class SourceType < Types::BaseObject
    field :id, Integer, null: false
    field :url, String, null: true
    field :downloads, [Types::DownloadType], null: true
  end
end
