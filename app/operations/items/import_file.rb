module Items
  class ImportFile
    include Dry::Monads[:result]
    include Dry::Monads::Do.for(:call)

    include Podify::Import['expand_path', 'items.create']

    def call(path)
      path = yield expand_path.call(path)
      yield assert_file(path)
      yield assert_not_yet_imported(path)
      title = yield infer_title(path)
      create.call(path: path, title: title)
    end

    def assert_file(path)
      return Failure(:not_a_file) unless path.file?
      Success()
    end

    def assert_not_yet_imported(path)
      return Failure(:already_exists) if Item.by_path(path).any?
      Success()
    end

    def infer_title(path)
      Success(path.basename.sub_ext('').to_s.capitalize)
    end
  end
end
