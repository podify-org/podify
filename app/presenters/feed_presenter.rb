class FeedPresenter < ApplicationPresenter
  def rss_url
    Rails.application.routes.url_helpers.feed_url(token, format: :rss)
  end

  def requests
    object.requests.map { |req| RequestPresenter.new(req) }
  end
end
