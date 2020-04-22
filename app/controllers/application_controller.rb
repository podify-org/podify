class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_raven_context

  before_action do
    Dry::View.reset_cache! # TODO: only in development
  end

  private

  def set_raven_context
    # Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
