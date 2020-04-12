Dry::Rails.container do
  # cherry-pick features
  config.features = %i[application_contract safe_params controller_helpers]

  # enable auto-registration in the lib dir
  auto_register!('lib')
  auto_register!('app/operations')
end
