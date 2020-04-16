require 'dry/cli'

module CLI
  module Commands
    module Sources
      class Fetch < Dry::CLI::Command
        desc "Fetch sources"

        include Podify::Import[
          'events',
          'downloader.fetch_source'
        ]

        option :all, type: :boolean, default: false, desc: 'Select all sources'
        option :id, type: :integer, desc: 'Select a source by id'

        def call(all:, id: nil, args: [])
          subscribe_to_events

          if all
            puts "all not yet implemented"
          elsif id
            source = Source[id]
            if source
              fetch_source source
            else
              puts "There is no source with id #{id}"
            end
          else
            puts "Don't know which sources to delete"
          end
        end

        def subscribe_to_events
        end
      end
    end
  end
end
