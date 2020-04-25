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
    render html: render_view('sources.index')
  end

  def create
    case resolve('sources.create').call(safe_params[:source])
    in Dry::Monads::Success(source)
      puts "CREATED #{source.id}"
      redirect_to root_path
    in Dry::Monads::Failure(validation)
      puts validation.errors(full: true).to_a.map(&:to_s).join(", ")
      render html: Views::Sources::Index.new.call.to_s.html_safe
    end
  end
end
