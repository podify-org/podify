require 'dry/cli'

module CLI
  module Commands
    module Sources
      class Delete < Dry::CLI::Command
        desc "Delete sources"

        include Podify::Import['sources.destroy']

        option :all, type: :boolean, default: false, desc: 'Delete all sources'

        def call(all:, args: [])
          if all
            Source.each do |source|
              destroy.call(source)
            end
          else
            puts "Don't know which sources to delete"
          end
        end
      end
    end
  end
end
