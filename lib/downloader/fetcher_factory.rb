module Downloader
  class FetcherFactory
    include Podify::Import['downloader.fetchers.youtube_dl']

    def call(source)
      # We only have this one fetcher at the moment
      youtube_dl
    end
  end
end
