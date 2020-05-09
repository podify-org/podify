class FeedPresenter < ApplicationPresenter
  def rss_url
    Rails.application.routes.url_helpers.feed_url(token, format: :rss)
  end
end
