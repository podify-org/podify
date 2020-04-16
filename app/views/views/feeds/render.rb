module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:sources) { Source.eager(:downloads).all }
    end
  end
end
