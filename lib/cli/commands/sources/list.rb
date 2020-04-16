require 'dry/cli'

module CLI
  module Commands
    module Sources
      class List < Dry::CLI::Command
        desc "List sources"

        def call(args: [])
          Source.paged_each do |source|
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
