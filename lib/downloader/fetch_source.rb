module Downloader
  class FetchSource
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'downloader.fetcher_factory',
      'downloads.import_file',
    ]

    def call(source)
      fetcher = fetcher_factory.call(source)
      path = yield fetcher.call(source)
      download = yield import_file.call(path, source: source)
      Success(download)
    end
  end
end
