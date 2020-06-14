module Types
  include Dry.Types()

  Pathname = Types.Instance(Pathname)

  module Coercible
    Pathname = Types::Pathname.constructor { |path| Pathname(path) }

    YesNoBoolean = Types.Constructor(TrueClass) do |input|
      next input if input === true || input === false

      case input.to_s.downcase
      when 'yes', 'y', 'true'
        true
      when 'no', 'n', 'false'
        false
      else
        raise ArgumentError, "Invalid input to Types::Coercible::YesNoBoolean: #{input.inspect}"
      end
    end
  end
end
