require "dry/view/context"

class ApplicationViewContext < Dry::View::Context
  include Devise::Controllers::Helpers

  def request
    _options[:request]
  end

  def method_missing(name, *args, &block)
    if url_helpers.respond_to?(name)
      url_helpers.public_send(name, *args, &block)
    elsif helpers.respond_to?(name)
      helpers.public_send(name, *args, &block)
    else
      super
    end
  end

  private

  def respond_to_missing?(name, include_private = false)
    url_helpers.respond_to?(name, include_private) ||
      helpers.respond_to?(name, include_private) ||
      super
  end

  def url_helpers
    @url_helpers ||= Rails.application.routes.url_helpers
  end

  def helpers
    @helpers ||= ApplicationController.helpers
  end
end
