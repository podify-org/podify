module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:sources) { |user:| user.sources.map { |s| SourcePresenter.new(s) } }
    end
  end
end
