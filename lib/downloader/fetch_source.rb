module Downloader
  class FetchSource
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'downloader.fetcher_factory',
      'events',
      create_download: 'downloads.create',
    ]

    def call(source)
      fetcher = yield fetcher_factory.call(source)
      path = yield fetcher.call(source)
      events.publish('downloader.fetch_source.fetched', path: path)
      download = yield create_download.call(path: path.to_s, source_id: source.id)
      Success(download)
    end
  end
end
