module Views
  module Sources
    class Index < ApplicationView
      config.template = "sources/index"

      expose(:sources) { |user:| user.sources }
      expose(:new_source, as: :source) { Source.new }
    end
  end
end
