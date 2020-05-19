module Downloads
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'downloads.contract'
    ]

    def call(attrs)
      attrs = yield validate(attrs)
      file = yield get_file(attrs[:path])
      download = yield create_download(attrs: attrs, file: file)
      events.publish('downloads.created', download: download)
      Success(download)
    end

    def validate(attrs)
      Success(yield(contract.call(attrs).to_monad).to_h)
    end

    def get_file(path)
      pathname = Pathname(path)
      return Failure(:not_a_file) unless pathname.file?

      Success(pathname.open('r'))
    end

    def ensure_unique_path(path)
      if Download.by_path(path).any?
        Failure('downloads.create.path_exists')
      else
        Success(true)
      end
    end

    def create_download(attrs:, file:)
      Success(Download.create(attrs.merge(file: file)))
    end
  end
end
