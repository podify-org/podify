module Sources
  class Contract < ApplicationContract
    params do
      required(:url).filled(:string)
    end
  end
end
