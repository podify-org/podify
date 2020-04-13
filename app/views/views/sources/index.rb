module Views
  module Sources
    class Index < ApplicationView
      config.template = "sources/index"

      expose(:sources) { Source.all }
      expose(:new_source) { Source.new }
    end
  end
end
