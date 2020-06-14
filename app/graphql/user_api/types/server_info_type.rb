module UserAPI
  module Types
    class ServerInfoType < Types::BaseObject
      field :root_url, String, null: false
    end
  end
end
