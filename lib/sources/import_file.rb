module Sources
  class ImportFile
    include Dry::Monads[:result, :do, :maybe]
    include Dry::Effects::Handler.Defer

    include Podify::Import[
      'expand_path',
      find_or_create_source: 'sources.find_or_create',
    ]

    def call(path)
      with_defer do
        DB.transaction do
          path = yield expand_path.call(path)
          yield assert_file(path)
          source = yield get_source(path)
          next Success(source)
        end
      end
    end

    def assert_file(path)
      return Failure(:not_a_file) unless path.file?
      Success()
    end

    def get_source(path)
      source = yield find_or_create_source.call("file://#{path}")
      Success(source)
    end
  end
end
