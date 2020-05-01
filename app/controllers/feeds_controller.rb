require 'rss'

class FeedsController < ApplicationController
  before_action :authenticate_user!

  schema(:show) do
    required(:collection).filled(:string)
  end

  def show
    raise ActionController::RoutingError.new("Format not supported") unless request.format.rss?
    raise ActionController::RoutingError.new("Only the 'all' collection is supported for now") unless safe_params[:collection] == 'all'

    render xml: render_view('feeds.render', user: current_user)
  end
end
