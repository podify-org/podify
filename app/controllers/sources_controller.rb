class SourcesController < ApplicationController
  def index
    render html: Views::Sources::Index.new.call.to_s.html_safe
  end
end
