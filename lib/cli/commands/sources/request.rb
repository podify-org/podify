require 'dry/cli'
require 'cli/commands/sources/selection'
require 'cli/commands/user'

module CLI
  module Commands
    module Sources
      class Request < Dry::CLI::Command
        desc "Create requests for sources from a user"

        include Dry::Monads[:result]

        include Podify::Import[
          create_request: 'requests.create',
        ]

        include Selection
        include User

        def call(**args)
          user = selected_user(args)
          selected_sources(args).each do |source|
            case create_request.call(user_id: user.id, source_id: source.id)
            in Success(request)
              puts "#{request.source.url} requested"
            in Failure('requests.create.exists')
              puts "Already requested #{source.url}"
            in Failure(failure)
              puts "Failed requesting #{source.url}: #{failure}"
            end
          end
        end
      end
    end
  end
end
