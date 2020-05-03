module UserAPI
  module Types
    class SourceType < Types::BaseObject
      field :id, Integer, null: false
      field :url, String, null: false
      field :title, String, null: true
      field :author, String, null: true
      field :thumbnail_url, String, null: true

      field :download_status, Types::DownloadStatusType, null: true
      field :last_download, Types::DownloadType, null: true
      field :downloads, [Types::DownloadType], null: false
    end
  end
end
