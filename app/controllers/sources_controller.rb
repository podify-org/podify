class SourcesController < ApplicationController
  def index
    render html: Views::Sources::Index.new.call.to_s.html_safe
  end

  def create
    attrs = resolve('source_contract').call(params[:source])
    pp attrs
  end
end
