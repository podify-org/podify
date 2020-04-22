module Downloads
  class Contract < ApplicationContract
    params do
      required(:path).filled(:string)
      required(:source_id).value(:integer)
      required(:fetcher).filled(:string)
      required(:fetcher_information).value(:hash)
      optional(:author).filled(:string)
      optional(:title).filled(:string)
      optional(:thumbnail_url).filled(:string)
    end
  end
end
