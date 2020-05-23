class ApplicationPresenter
  extend Dry::Initializer

  param :object

  def self.wrap(object)
    new(object)
  end

  def self.wrap_all(objects)
    objects.map { |object| wrap(object) }
  end

  def self.forward_or_nil(*methods, to:)
    methods.each do |method|
      define_method method do
        send(to)&.send(method)
      end
    end
  end

  def respond_to_missing?(method, *a, &b)
    object.respond_to?(method, *a, &b)
  end

  private

  def method_missing(method, *a, &b)
    if object.respond_to?(method)
      object.send(method, *a, &b)
    else
      super
    end
  end
end
