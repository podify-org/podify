module Downloads
  class Contract < ApplicationContract
    params do
      required(:path).filled(:string)
      required(:source_id).value(:integer)
      required(:fetcher).filled(:string)
      required(:fetcher_information).value(:hash)
      optional(:author).value(:string)
      optional(:title).value(:string)
      optional(:thumbnail_url).value(:string)
    end
  end
end
