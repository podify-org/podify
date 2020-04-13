module Parts
  class Source < ApplicationPart
    def form
      render :form, source: self
    end
  end
end
