require 'dry/validation'
require 'dry/monads'

Dry::Validation.load_extensions(:monads)

class ApplicationContract < Dry::Validation::Contract
  config.messages.top_namespace = :contracts
  config.messages.backend = :i18n
  config.messages.load_paths += Dir[Rails.root.join("config/locales/*.yml")]
end
