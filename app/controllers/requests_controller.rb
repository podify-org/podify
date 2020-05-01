class RequestsController < ApplicationController
  before_action :authenticate_user!

  schema(:create) do
    required(:url).filled(:string)
  end

  def create
    case resolve('requests.create_for_url').call(user: current_user, url: safe_params[:url])
    in Dry::Monads::Success(request)
    in Dry::Monads::Failure(validation)
      puts validation.errors(full: true).to_a.map(&:to_s).join(", ")
    end
    redirect_to root_path
  end
end
