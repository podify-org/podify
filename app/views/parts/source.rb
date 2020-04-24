module Parts
  class Source < ApplicationPart
    def display_title
      downloads.last&.title || url
    end

    def render_form
      render :form, source: self
    end

    def render_list_entry
      render :list_entry, source: self
    end
  end
end
