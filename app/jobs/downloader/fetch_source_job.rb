module Downloader
  class FetchSourceJob
    include Sidekiq::Worker
    include Dry::Monads[:result]

    include Podify::Import['downloader.fetch_source']

    def perform(source_id)
      source = Source[source_id]
      return unless source

      fetch_source.call(source).or do |failure|
        case failure
        when Dry::Validation::Result
          Rails.logger.error failure.errors.to_h
        when 'downloads.create.path_exists'
          # already fetched, all good
        else
          Rails.logger.error failure
          raise "Failed (#{failure})"
        end
      end
    rescue => e
      puts e
      puts e.backtrace
      raise
    end
  end
end
