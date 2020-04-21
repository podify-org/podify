module Downloader
  module Fetchers
    class File
      include Dry::Monads[:result, :do]

      def call(source)
        path = yield get_path(source.url)
        Success(path)
      end

      def get_path(url)
        if url =~ %r{\Afile://}i
          Success(url.sub(%r{\Afile://}i, ''))
        else
          Failure('downloader.fetchers.file.not_a_file_url')
        end
      end
    end
  end
end
