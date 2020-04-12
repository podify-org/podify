module Items
  class Create
    include Dry::Monads[:result, :do]

    def call(attributes)
      yield validate(attributes)
      item = yield create_item(attributes)
      Success(item)
    end

    def validate(attributes)
      return Failure(:attributes_missing) unless attributes
      return Failure(:title_missing) unless attributes[:title]
      return Failure(:path_missing) unless attributes[:path]
      Success()
    end

    def create_item(attrs)
      Success(Item.create(attrs))
    end
  end
end
