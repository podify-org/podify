module Sources
  class Contract < ApplicationContract
    params do
      required(:url).filled(:string)
      optional(:title).value(:string)
    end
  end
end
