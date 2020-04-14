require 'dry/cli'
require 'cli/commands/downloads/import'
require 'cli/commands/sources/delete'

module CLI
  module Commands
    extend Dry::CLI::Registry

    register "downloads", aliases: ["d"] do |prefix|
      prefix.register "import", Downloads::Import, aliases: ['i']
    end

    register "sources", aliases: ["s"] do |prefix|
      prefix.register "delete", Sources::Delete, aliases: ['d']
    end
  end
end
