module Downloader
  class Result < Dry::Struct
    attribute :fetcher, Types::String
    attribute :path, Types::Pathname
    attribute :author, Types::String.meta(omittable: true)
    attribute :title, Types::String.meta(omittable: true)
    attribute :thumbnail_url, Types::String.meta(omittable: true)
    attribute :fetcher_information, Types::Hash
  end
end
