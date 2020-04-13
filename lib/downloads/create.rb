module Downloads
  class Create
    include Dry::Monads[:result, :do]

    def call(attributes)
      yield validate(attributes)
      download = yield create_download(attributes)
      Success(download)
    end

    def validate(attributes)
      return Failure(:attributes_missing) unless attributes
      return Failure(:path_missing) unless attributes[:path]
      return Failure(:source_missing) unless attributes[:source_id]
      Success()
    end

    def create_download(attrs)
      Success(Download.create(attrs))
    end
  end
end
