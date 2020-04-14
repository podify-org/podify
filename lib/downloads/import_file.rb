module Downloads
  class ImportFile
    include Dry::Monads[:result, :do, :maybe]

    include Podify::Import[
      'expand_path',
      create_download: 'downloads.create',
      create_source: 'sources.create',
    ]

    def call(path, source: nil)
      DB.transaction do
        path = yield expand_path.call(path)
        yield assert_file(path)
        yield assert_not_yet_imported(path)
        source ||= yield get_source(path)
        create_download.call(path: path.to_s, source_id: source.id)
      end
    end

    def assert_file(path)
      return Failure(:not_a_file) unless path.file?
      Success()
    end

    def assert_not_yet_imported(path)
      return Failure(:already_exists) if Download.by_path(path).any?
      Success()
    end

    def get_source(path)
      find_existing_source(path).or do
        title = yield infer_title(path)
        source = yield create_source.call(title: title, url: "file://#{path}")
        Success(source)
      end
    end

    def find_existing_source(path)
      Maybe(Source.by_file_path(path).first)
    end

    def infer_title(path)
      Success(path.basename.sub_ext('').to_s.capitalize)
    end
  end
end