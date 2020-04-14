require 'dry/cli'

module CLI
  module Commands
    module Downloads
      class Import < Dry::CLI::Command
        desc "Import existing files or directories as downloads"

        include Podify::Import['downloads.import_file', 'downloads.import_directory']

        def call(args: [])
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

            puts "Importing #{path}"
            pp import.call(path)
            puts
          end
        end
      end
    end
  end
end
