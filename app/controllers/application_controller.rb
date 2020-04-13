class ApplicationController < ActionController::Base
  before_action do
    Dry::View.reset_cache! # TODO: only in development
  end
end
