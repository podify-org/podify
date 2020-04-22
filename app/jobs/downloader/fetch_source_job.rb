module Downloader
  class FetchSourceJob
    include Sidekiq::Worker

    include Podify::Import['downloader.fetch_source']

    def perform(source_id)
      source = Source[source_id]
      return unless source

      fetch_source.call(source).or do |failure|
        raise "Failed (#{failure})"
      end
    end
  end
end
