module Requests
  class Contract < ApplicationContract
    params do
      required(:user_id).value(:integer)
      required(:source_id).value(:integer)
      required(:feed_id).value(:integer)
    end
  end
end
