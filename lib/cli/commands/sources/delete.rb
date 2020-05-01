require 'dry/cli'
require 'cli/commands/sources/selection'

module CLI
  module Commands
    module Sources
      class Delete < Dry::CLI::Command
        desc "Delete sources"

        include Podify::Import[
          'events',
          'sources.destroy'
        ]

        include Selection

        def call(**args)
          subscribe_to_events

          selected_sources(args).each do |source|
            destroy.call(source)
          end
        end

        def subscribe_to_events
          events.subscribe('sources.destroyed') do |event|
            puts "Deleted source #{event[:source].url}"
          end
          events.subscribe('downloads.destroyed') do |event|
            puts "Deleted download #{event[:download].path}"
          end
        end
      end
    end
  end
end
