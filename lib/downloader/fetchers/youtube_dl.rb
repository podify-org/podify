module Downloader
  module Fetchers
    class YoutubeDl
      include Dry::Monads[:result, :do]

      include Podify::Import['settings', 'downloader.result']

      def call(source)
        video = yield download(source)
        Success(create_result(video))
      end

      def download(source)
        Success(YoutubeDL.download(source.url, arguments(source)))
      rescue Terrapin::ExitStatusError => e
        handle_youtube_dl_error(e.message)
      end

      def arguments(source)
        {
          format: 'mp4',
          output: output_template(source),
        }
      end

      def output_template(source)
        (storage_dir(source) / '%(title)s.%(ext)s').to_s
      end

      def storage_dir(source)
        dir = settings.storage_dir / source.id.to_s.rjust(10, '0')
        dir.mkpath
        dir
      end

      def handle_youtube_dl_error(error)
        match = error.match(/STDERR:\n\n(.*)/m)
        if match
          handle_command_error(match[1])
        else
          raise "Unexpected error: #{error}" unless match
        end
      end

      def handle_command_error(output)
        Failure(['downloads.fetcher.unknown_error', output: output])
      end

      def create_result(video)
        result.new(
          fetcher: 'youtube_dl',
          path: Pathname.new(video.filename),
          author: video.information[:uploader],
          title: video.information[:title],
          thumbnail_url: video.information[:thumbnail],
          fetcher_information: video.information,
        )
      end
    end
  end
end
