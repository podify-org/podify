module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:sources) { |feed:| feed.requests.map { |request| SourcePresenter.new(request.source) } }
    end
  end
end
