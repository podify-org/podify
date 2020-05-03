class ApplicationPresenter < Delegator
  extend Dry::Initializer

  param :object

  def self.forward_or_nil(*methods, to:)
    methods.each do |method|
      define_method method do
        send(to)&.send(method)
      end
    end
  end

  def __getobj__
    object
  end
end
