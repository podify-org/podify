module Downloads
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'downloads.contract'
    ]

    def call(attrs)
      attrs = yield validate(attrs)
      yield ensure_file(attrs[:path])
      yield ensure_unique_path(attrs[:path])
      download = yield create_download(attrs)
      events.publish('downloads.created', download: download)
      Success(download)
    end

    def validate(attrs)
      Success(yield(contract.call(attrs).to_monad).to_h)
    end

    def ensure_file(path)
      return Failure(:not_a_file) unless Pathname(path).file?
      Success()
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
