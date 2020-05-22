module Feeds
  class Contract < ApplicationContract
    params do
      required(:name).filled(:string)
      required(:user_id).value(:integer)
    end
  end
end
