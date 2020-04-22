module Types
  include Dry.Types()

  Pathname = Types.Instance(Pathname)

  module Coercible
    Pathname = Types::Pathname.constructor { |path| Pathname(path) }
  end
end
