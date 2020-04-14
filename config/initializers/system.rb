Dry::Rails.container do
  # cherry-pick features
  config.features = %i[application_contract safe_params controller_helpers]

  register('events', memoize: true) do
    require 'events'
    Events.new
  end

  # enable auto-registration in the lib dir
  auto_register!('lib')
end
