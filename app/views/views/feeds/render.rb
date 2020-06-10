module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:feed) { |feed:| FeedPresenter.wrap(feed) }
      expose(:sources) { |feed:| SourcePresenter.wrap_all(feed.requests.map(&:source)) }
      expose(:feed_url) { |feed:| Rails.application.routes.url_helpers.root_url + "/feeds/#{feed.id}" }
    end
  end
end
