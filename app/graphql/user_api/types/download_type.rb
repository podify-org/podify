module UserAPI
  module Types
    class DownloadType < Types::BaseObject
      field :id, Integer, null: false
      field :title, String, null: false
    end
  end
end
