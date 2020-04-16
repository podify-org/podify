require 'rss'

class FeedsController < ApplicationController
  schema(:show) do
    required(:collection).filled(:string)
  end

  def show
    raise ActionController::RoutingError.new("Format not supported") unless request.format.rss?
    raise ActionController::RoutingError.new("Only the 'all' collection is supported for now") unless safe_params[:collection] == 'all'

    render xml: Views::Feeds::Render.new.call.to_s
  end
end
