require 'dry/cli'
require 'cli/commands/downloads/delete'
require 'cli/commands/sources/list'
require 'cli/commands/sources/add'
require 'cli/commands/sources/import'
require 'cli/commands/sources/fetch'
require 'cli/commands/sources/delete'

module CLI
  module Commands
    extend Dry::CLI::Registry

    register "downloads", aliases: ["d"] do |prefix|
      prefix.register "delete", Downloads::Delete, aliases: ['d']
    end

    register "sources", aliases: ["s"] do |prefix|
      prefix.register "list", Sources::List, aliases: ['l']
      prefix.register "add", Sources::Add, aliases: ['a']
      prefix.register "import", Sources::Import, aliases: ['i']
      prefix.register "fetch", Sources::Fetch, aliases: ['f']
      prefix.register "delete", Sources::Delete, aliases: ['d']
    end
  end
end
