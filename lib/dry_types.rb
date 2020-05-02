module DryTypes
  include Dry.Types()

  Pathname = DryTypes.Instance(Pathname)

  module Coercible
    Pathname = DryTypes::Pathname.constructor { |path| Pathname(path) }
  end
end
