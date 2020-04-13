class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action do
    Dry::View.reset_cache! # TODO: only in development
  end
end
