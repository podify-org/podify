require_relative 'boot'

require "rails"
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Podify
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.autoload_paths << Rails.root.join('app/views')

    # Remove heinous monkey patch
    Dry::View::Part.undef_method :to_param

    # config.sequel.skip_connect = true
    Sequel.extension(:pg_json_ops)

    config.sequel.after_connect = proc do |conn|
      Sequel::Model.plugin :timestamps, update_on_create: true
      Sequel::Model.plugin :association_dependencies

      Sequel::Model.db.extension :pg_array
      Sequel::Model.db.extension :pg_json
      Sequel::Model.db.extension :pg_enum
    end

    if ENV['URL_HOST']
      Rails.application.routes.default_url_options[:host] = ENV['URL_HOST']
    elsif ENV['HOST']
      Rails.application.routes.default_url_options[:host] = "http#{'s' if ENV['SSL']}://#{ENV.fetch('HOST')}:#{ENV.fetch('PORT')}"
      config.hosts << ENV.fetch('HOST')
    end

    if ENV['EXTRA_HOSTS']
      config.hosts += ENV['EXTRA_HOSTS'].split(',')
    end

    if ENV['FIX_DOCKER_LOGS']
      log_out = IO.new(IO.sysopen("/proc/1/fd/1", "w"),"w")
      log_out.sync = true
      config.logger = Logger.new(log_out)
    end

    Raven.configure do |config|
      config.dsn = ENV['SENTRY_DSN']
    end
  end
end
