module Downloads
  class Contract < ApplicationContract
    params do
      required(:path).filled(:string)
      required(:source_id).value(:integer)
    end
  end
end
