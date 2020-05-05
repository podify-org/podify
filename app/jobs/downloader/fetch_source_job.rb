module Downloader
  class FetchSourceJob
    include Sidekiq::Worker
    include Dry::Monads[:result]
    include Dry::Effects::Handler.Resolve

    include Podify::Import['downloader.fetch_source']

    def perform(source_id)
      source = Source[source_id]
      raise "Source #{source_id} not found" unless source

      provide('downloader.fetch_source.progress_callback' => BroadcastProgressCallback.new(source)) do
        fetch_source.call(source).or do |failure|
          ap failure

          case failure
          when Dry::Validation::Result
            Rails.logger.error failure.errors.to_h
          when 'downloads.create.path_exists'
            broadcast.call
            # already fetched, all good
          when 'downloader.fetcher_factory.no_fetcher_for_scheme'
            # no need to retry
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
        progress(0)
      end

      def progress(progress)
        # TODO: throttle this to a reasonable level
        broadcast.progress(progress)
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
