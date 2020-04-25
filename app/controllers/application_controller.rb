class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  skip_before_action :verify_authenticity_token
  before_action :set_raven_context

  before_action do
    Dry::View.reset_cache! # TODO: only in development
  end

  private

  ##### dry-view helpers
  def render_view(identifier, with: {}, **input)
    container["views.#{identifier}"].(
      context: view_context(**with),
      **input
    ).to_s.html_safe
  end

  def view_context(**options)
    container["application_view_context"].with(view_context_options(**options))
  end

  def view_context_options(**overrides)
    {
      request: request
    }.merge(overrides)
  end

  def container
    Podify::Container
  end


  def set_raven_context
    # Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
