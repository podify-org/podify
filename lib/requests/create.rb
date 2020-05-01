module Requests
  class Create
    include Dry::Monads[:result, :do]

    include Podify::Import['events', 'requests.contract']

    def call(attrs)
      attrs = yield(contract.call(attrs).to_monad).to_h
      yield ensure_uniqueness(attrs)
      request = yield create_request(attrs)
      events.publish('requests.created', request: request)
      Success(request)
    end

    def ensure_uniqueness(attrs)
      return Failure('requests.create.exists') if Request.where(attrs).count > 0
    end

    def create_request(attrs)
      Success(Request.create(attrs))
    end
  end
end
