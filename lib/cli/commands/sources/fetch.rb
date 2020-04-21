require 'dry/cli'

module CLI
  module Commands
    module Sources
      class Fetch < Dry::CLI::Command
        include Dry::Monads[:result]

        include Podify::Import[
          'events',
          'downloader.fetch_source'
        ]

        desc "Fetch sources"

        option :all, type: :boolean, default: false, desc: 'Select all sources'
        option :id, type: :integer, desc: 'Select a source by id'

        def call(all:, id: nil, args: [])
          if all
            puts "all not yet implemented"
          elsif id
            source = Source[id]
            if source
              case fetch_source.call(source).tap { |r| ap r }
              in Success(download)
                puts "Downloaded to '#{download.path}'"
              in Failure(error, {output:})
                puts "Failed with #{error}. Output:\n\n#{output}"
              in failure
                puts "Unknown failure: #{failure}"
              end
            else
              puts "There is no source with id #{id}"
            end
          else
            puts "Don't know which sources to fetch"
          end
        end
      end
    end
  end
end
