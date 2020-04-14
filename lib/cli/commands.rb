require 'dry/cli'
require 'cli/commands/downloads/import'

module CLI
  module Commands
    extend Dry::CLI::Registry

    register "downloads", aliases: ["d"] do |prefix|
      prefix.register "import", Downloads::Import, aliases: ['i']
    end
  end
end
