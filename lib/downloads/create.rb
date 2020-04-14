module Downloads
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'downloads.contract'
    ]

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      download = yield create_download(attrs)
      events.publish('downloads.created', download: download)
      Success(download)
    end

    def create_download(attrs)
      Success(Download.create(attrs))
    end
  end
end
