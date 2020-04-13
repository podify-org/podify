class SourcesController < ApplicationController
  schema(:show, :edit) do
    required(:id).value(:integer)
  end

  schema(:create, :update) do
    required(:source).hash do
      required(:url).filled(:string)
      optional(:title).filled(:string)
    end
  end

  def show
    render html: Views::Sources::Show.new.call.to_s.html_safe
  end

  def index
    render html: Views::Sources::Index.new.call.to_s.html_safe
  end

  def create
    attrs = safe_params[:source]
    Source.create(attrs)
    redirect_to root_path
  end
end
