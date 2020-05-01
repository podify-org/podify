module Views
  module Feeds
    class Render < ApplicationView
      config.template = "feeds/render"
      config.layout = nil
      config.default_format = :rss

      expose(:sources) { |user:| user.sources_dataset.eager(:downloads).all }
    end
  end
end
