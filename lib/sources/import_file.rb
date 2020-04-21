module Sources
  class ImportFile
    include Dry::Monads[:result, :do, :maybe]

    include Podify::Import[
      'expand_path',
      create_source: 'sources.create',
    ]

    def call(path)
      DB.transaction do
        path = yield expand_path.call(path)
        yield assert_file(path)
        source = yield get_source(path)
        return Success(source)
      end
    end

    def assert_file(path)
      return Failure(:not_a_file) unless path.file?
      Success()
    end

    def get_source(path)
      url = "file://#{path}"
      find_existing_source(url).or do
        title = yield infer_title(path)
        source = yield create_source.call(title: title, url: url)
        Success(source)
      end
    end

    def find_existing_source(url)
      Maybe(Source.by_url(url).first)
    end

    def infer_title(path)
      Success(path.basename.sub_ext('').to_s)
    end
  end
end
