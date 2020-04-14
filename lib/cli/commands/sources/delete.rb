require 'dry/cli'

module CLI
  module Commands
    module Sources
      class Delete < Dry::CLI::Command
        desc "Delete sources"

        include Podify::Import[
          'events',
          'sources.destroy'
        ]

        option :all, type: :boolean, default: false, desc: 'Delete all sources'

        def call(all:, args: [])
          subscribe_to_events

          if all
            Source.each do |source|
              destroy.call(source)
            end
          else
            puts "Don't know which sources to delete"
          end
        end

        def subscribe_to_events
          events.subscribe('sources.destroyed') do |event|
            puts "Deleted source #{event[:source].title}"
          end
          events.subscribe('downloads.destroyed') do |event|
            puts "Deleted download #{event[:download].path}"
          end
        end
      end
    end
  end
end
