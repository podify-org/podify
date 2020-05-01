require 'dry/cli'
require 'cli/commands/sources/selection'

module CLI
  module Commands
    module Sources
      class Fetch < Dry::CLI::Command
        include Dry::Monads[:result]

        include Podify::Import[
          'events',
          'downloader.fetch_source'
        ]

        include Selection

        desc "Fetch sources"

        def call(**args)
          selected_sources(args).each do |source|
            puts "Downloading source #{source.id}: '#{source.url}'"
            case fetch_source.call(source)
            in Success(download)
              puts "Downloaded to '#{download.path}'"
            in Failure(error, {output:})
              puts "Failed with #{error}. Output:\n\n#{output}"
            in failure
              puts "Unknown failure: #{failure}"
            end
          end
        end
      end
    end
  end
end
