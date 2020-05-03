module Downloader
  class FetchSource
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'downloader.fetcher_factory',
      'events',
      create_download: 'downloads.create',
    ]

    include Dry::Effects.Resolve(progress_callback: 'downloader.fetch_source.progress_callback')

    def call(source)
      progress_callback.start_download

      fetcher = yield fetcher_factory.call(source)
      result = yield fetcher.call(source)
      events.publish('downloader.fetch_source.fetched', result: result)
      download = yield create_download_from_result(result: result, source: source)

      progress_callback.complete

      Success(download)
    end

    def create_download_from_result(result:, source:)
      download = yield create_download.call(**result.to_h, path: result[:path].to_s, source_id: source.id)
      Success(download)
    end
  end
end
