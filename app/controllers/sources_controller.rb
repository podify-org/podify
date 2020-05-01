class SourcesController < ApplicationController
  before_action :authenticate_user!

  schema(:show, :edit) do
    required(:id).value(:integer)
  end

  schema(:create, :update) do
    required(:source).hash
  end

  def show
    render html: render_view('sources.show')
  end

  def index
    render html: render_view('sources.index', user: current_user)
  end
end
