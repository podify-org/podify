class ExpandPath
  include Dry::Monads[:result, :do]
  include Dry::Monads::Do.for(:call)

  def call(path)
    path = Pathname(path)
    Success(path.realpath)
  rescue
    Failure(:does_not_exist)
  end
end
