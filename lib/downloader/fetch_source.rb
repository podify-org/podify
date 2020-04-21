module Downloader
  class FetchSource
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'downloader.fetcher_factory',
      'downloads.import_file',
      'events',
    ]

    def call(source)
      fetcher = yield fetcher_factory.call(source)
      path = yield fetcher.call(source)
      events.publish('downloader.fetch_source.fetched', path: path)
      download = yield import_file.call(path, source: source)
      Success(download)
    end
  end
end
