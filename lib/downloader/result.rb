module Downloader
  class Result < Dry::Struct
    attribute :fetcher, Types::String
    attribute :path, Types::Pathname
    attribute :author, Types::String.optional
    attribute :title, Types::String.optional
    attribute :thumbnail_url, Types::String.optional
    attribute :fetcher_information, Types::Hash
  end
end
