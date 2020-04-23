module Downloader
  module Fetchers
    class File
      include Dry::Monads[:result, :do]

      include Podify::Import['downloader.result']

      def call(source)
        path = yield get_path(source.url)
        Success(create_result(path))
      end

      def get_path(url)
        if url =~ %r{\Afile://}i
          Success(Pathname(url.sub(%r{\Afile://}i, '')))
        else
          Failure('downloader.fetchers.file.not_a_file_url')
        end
      end

      def create_result(path)
        result.new(
          fetcher: 'file',
          path: path,
          title: path.basename.sub_ext('').to_s,
          fetcher_information: {},
        )
      end
    end
  end
end
