module UserAPI
  module Types
    class DownloadStatusType < Types::BaseObject
      field :status, String, null: false
      field :place_in_queue, String, null: true
      field :retry_status, String, null: true
    end
  end
end
