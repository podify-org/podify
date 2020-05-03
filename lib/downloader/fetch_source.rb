module Downloader
  class FetchSource
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'downloader.fetcher_factory',
      'events',
      create_download: 'downloads.create',
    ]

    def call(source)
      broadcast = download_status_broadcast(source)
      broadcast.progress(10)

      fetcher = yield fetcher_factory.call(source)
      result = yield fetcher.call(source)
      events.publish('downloader.fetch_source.fetched', result: result)
      download = yield create_download_from_result(result: result, source: source)

      broadcast.call

      Success(download)
    end

    def create_download_from_result(result:, source:)
      download = yield create_download.call(**result.to_h, path: result[:path].to_s, source_id: source.id)
      Success(download)
    end

    private

    def download_status_broadcast(source)
      Broadcasts::DownloadStatus.new(source: source)
    end
  end
end
