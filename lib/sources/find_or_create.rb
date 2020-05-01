module Sources
  class FindOrCreate
    include Dry::Monads[:result, :do, :maybe]

    include Podify::Import[
      'sources.create',
    ]

    def call(url)
      find(url).or do
        source = yield create.call(url: url)
        Success(source)
      end
    end

    def find(url)
      Maybe(Source.by_url(url).first)
    end
  end
end
