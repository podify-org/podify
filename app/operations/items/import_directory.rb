module Items
  class ImportDirectory
    include Dry::Monads[:result, :do]
    include Dry::Monads::Do.for(:call)

    include Podify::Import['expand_path', 'items.import_file']

    def call(path)
      path = yield expand_path.call(path)
      yield assert_directory(path)

      Success(
        all_files(path).map do |file|
          import_file.call(file)
        end.to_a
      )
    end

    def assert_directory(path)
      if path.directory?
        Success()
      else
        Failure(:not_a_directory)
      end
    end

    def all_files(path)
      path.find.lazy.select(&:file?)
    end
  end
end
