module UserAPI
  module Types
    class DownloadStatusType < Types::BaseObject
      field :status, String, null: false
    end
  end
end
