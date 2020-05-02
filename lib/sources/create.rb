module Sources
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'sources.contract',
      'downloader.fetch_source_job',
    ]

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      source = yield create_source(attrs)
      events.publish('sources.created', source: source)
      fetch_source_job.perform_async(source.id)
      Success(source)
    end

    def create_source(attrs)
      Success(Source.create(attrs))
    end
  end
end
