module Downloader
  class FetcherFactory
    include Dry::Monads[:result]

    include Podify::Import[
      'downloader.fetchers.file',
      'downloader.fetchers.youtube_dl',
    ]

    def call(source)
      case source.url
      when %r{\Afile://}i   then Success(file)
      when %r{\Ahttps?://}i then Success(youtube_dl)
      else Failure('downloader.fetcher_factory.no_fetcher_for_scheme')
      end
    end
  end
end
