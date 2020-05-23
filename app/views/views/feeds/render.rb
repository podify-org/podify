module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:feed) { |feed:| FeedPresenter.wrap(feed) }
      expose(:sources) { |feed:| SourcePresenter.wrap_all(feed.requests.map(&:source)) }
    end
  end
end
