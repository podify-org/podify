require 'dry/cli'

module CLI
  module Commands
    module Downloads
      class Delete < Dry::CLI::Command
        desc "Delete downloads"

        include Podify::Import[
          'events',
          'downloads.destroy'
        ]

        option :all, type: :boolean, default: false, desc: 'Delete all downloads'

        def call(all:, args: [])
          subscribe_to_events

          if all
            Download.each do |download|
              destroy.call(download)
            end
          else
            puts "Don't know which downloads to delete"
          end
        end

        def subscribe_to_events
          events.subscribe('downloads.destroyed') do |event|
            puts "Deleted #{event[:download].path}"
          end
        end
      end
    end
  end
end
