require 'dry/cli'

module CLI
  module Commands
    module Downloads
      class Import < Dry::CLI::Command
        desc "Import existing files or directories as downloads"

        include Podify::Import[
          'events',
          'downloads.import_file',
          'downloads.import_directory'
        ]

        def call(args: [])
          subscribe_to_events

          args.each do |arg|
            path = Pathname(arg)
            if path.file?
              import = import_file
            elsif path.directory?
              import = import_directory
            else
              puts "#{path} does not exist"
              next
            end

            puts "Importing #{path}..."
            import.call(path)
          end

          puts
          puts "Imported #{@imported} files"
        end

        def subscribe_to_events
          @imported = 0

          events.subscribe('sources.created') do |event|
            puts "Imported \"#{event[:source].title}\" from #{event[:source].url}"
            @imported += 1
          end
        end
      end
    end
  end
end
