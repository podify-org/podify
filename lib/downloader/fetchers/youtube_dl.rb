module Downloader
  module Fetchers
    class YoutubeDl
      include Dry::Monads[:result, :do]

      include Podify::Import[
        'settings',
        'downloader.result',
      ]

      include Dry::Effects.Resolve(progress_callback: 'downloader.fetch_source.progress_callback')

      def call(source)
        download_state = yield download(source)
        Success(create_result(download_state))
      end

      def download(source)
        YoutubeDL.download(source.url, arguments(source))
          .on_progress do |state:, **|
            progress_callback.progress(state.progress)
          end
          .on_complete do |state:, **|
            return Success(state)
          end
          .on_error do |state:, **|
            return handle_youtube_dl_error(state.error)
          end
          .call

        raise 'YoutubeDL finished without error but not complete either'
      end

      def arguments(source)
        {
          format: 'mp4,mp3',
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
        case output
        when /Unsupported URL:/
          Failure(['downloads.fetcher.unsupported', output: output])
        else
          Failure(['downloads.fetcher.unknown_error', output: output])
        end
      end

      def create_result(download_state)
        result.new(**{
          fetcher: 'youtube_dl',
          path: download_state.destination,
          author: download_state.info['uploader'],
          title: download_state.info['title'],
          thumbnail_url: download_state.info['thumbnail'],
          fetcher_information: download_state.info,
        }.compact)
      end
    end
  end
end
