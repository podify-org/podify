require 'dry/cli'

module CLI
  module Commands
    module Sources
      class Add < Dry::CLI::Command
        desc "Add a source"

        include Dry::Monads[:result]

        include Podify::Import[
          'sources.create'
        ]

        option :url, type: :string, required: true, desc: 'URL of the media source'
        option :title, type: :string, default: nil, desc: 'Title of the media'

        def call(url:, title: nil, args: [])
          case create.call({ url: url, title: title }.compact)
          in Success(source)
            puts "Source created, id: #{source.id}"
          in Failure(failure)
            puts "Failed:"
            ap failure
          end
        end
      end
    end
  end
end
