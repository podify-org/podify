module Types
  class SourceType < Types::BaseObject
    field :url, String, null: true
    field :downloads, [Types::DownloadType], null: true
  end
end
