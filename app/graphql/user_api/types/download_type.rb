module UserAPI
  module Types
    class DownloadType < Types::BaseObject
      field :id, Integer, null: false
      field :title, String, null: false
      field :author, String, null: true
      field :thumbnail_url, String, null: true
      field :format, String, null: true
    end
  end
end
