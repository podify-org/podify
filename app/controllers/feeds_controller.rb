class FeedsController < ApplicationController
  schema(:show) do
    required(:token).filled(:string)
  end

  def show
    raise ActionController::RoutingError.new("Format not supported") unless request.format.rss?

    feed = Feed.with_token!(safe_params[:token])
    render xml: render_view('feeds.render', feed: feed)
  end
end
