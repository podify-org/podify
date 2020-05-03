module Downloader
  class FetchSourceJob
    include Sidekiq::Worker
    include Dry::Monads[:result]
    include Dry::Effects::Handler.Resolve

    include Podify::Import['downloader.fetch_source']

    def perform(source_id)
      source = Source[source_id]
      return unless source

      provide('downloader.fetch_source.progress_callback' => BroadcastProgressCallback.new(source)) do
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
      end
    rescue => e
      puts e
      puts e.backtrace
      raise
    end

    private

    class BroadcastProgressCallback
      extend Dry::Initializer
      param :source

      def start_download
        broadcast.progress(1)
      end

      def complete
        broadcast.call
      end

      private

      def broadcast
        @broadcast ||= Broadcasts::DownloadStatus.new(source: source)
      end
    end
  end
end
