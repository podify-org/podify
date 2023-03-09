require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Podify
  class Application < Rails::Application
    config.load_defaults 7.0

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
      Sequel::Model.plugin :tactical_eager_loading

      Sequel::Model.db.extension :pg_array
      Sequel::Model.db.extension :pg_json
      Sequel::Model.db.extension :pg_enum
    end

    config.action_cable.mount_path = '/api/cable'

    if ENV['URL_HOST']
      Rails.application.routes.default_url_options[:host] = ENV['URL_HOST']
      config.action_controller.asset_host = ENV['URL_HOST']
    elsif ENV['HOST']
      host = "http#{'s' if ENV['SSL']}://#{ENV.fetch('HOST')}:#{ENV.fetch('PORT')}"
      Rails.application.routes.default_url_options[:host] = host
      config.action_controller.asset_host = host
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
