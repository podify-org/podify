module Users
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      'users.contract',
    ]

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      user = yield create_user(attrs)
      events.publish('users.created', user: user)
      Success(user)
    end

    def create_user(attrs)
      Success(DeviseUser.create(attrs))
    end
  end
end
