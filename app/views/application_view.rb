class ApplicationView < Dry::View
  config.paths = Rails.root.join('app/templates')
  config.default_context = ApplicationViewContext.new
  config.part_namespace = Parts
  # config.scope_namespace = Scopes
end
