require 'dry/cli'
require 'cli/commands/sources/selection'

module CLI
  module Commands
    module Sources
      class List < Dry::CLI::Command
        desc "List sources"

        include Selection

        def call(**args)
          selected_sources(args).each do |source|
            print "#{source.id}: #{source.url}"
            print " (#{source.title})" if source.title
            download = source.downloads.last
            print ": '#{download.path}'" if download
            puts
          end
        end
      end
    end
  end
end
