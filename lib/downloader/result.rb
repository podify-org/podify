module Downloader
  class Result < Dry::Struct
    attribute :fetcher, DryTypes::String
    attribute :path, DryTypes::Pathname
    attribute :author, DryTypes::String.meta(omittable: true)
    attribute :title, DryTypes::String.meta(omittable: true)
    attribute :thumbnail_url, DryTypes::String.meta(omittable: true)
    attribute :fetcher_information, DryTypes::Hash
  end
end
