class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  # append_view_path "app/templates"

  skip_before_action :verify_authenticity_token
  before_action :set_raven_context

  if Rails.env.development?
    before_action do
      Dry::View.reset_cache!
    end
  end

  private

  ##### dry-view helpers
  def render_view(identifier, with: {}, **input, &block)
    container["views.#{identifier}"].call(
      context: dry_view_context(**with),
      **input,
      &block
    ).to_s.html_safe
  end

  # view_context is defined by ActionView
  def dry_view_context(**options)
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
