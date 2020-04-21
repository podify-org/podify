module Downloads
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'downloads.contract'
    ]

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      yield ensure_unique_path(attrs[:path])
      download = yield create_download(attrs)
      events.publish('downloads.created', download: download)
      Success(download)
    end

    def ensure_unique_path(path)
      if Download.by_path(path).any?
        Failure('downloads.create.path_exists')
      else
        Success(true)
      end
    end

    def create_download(attrs)
      Success(Download.create(attrs))
    end
  end
end
