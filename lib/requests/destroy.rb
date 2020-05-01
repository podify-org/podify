module Requests
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
    ]

    def call(request)
      request.destroy
      events.publish('requests.destroyed', request: request)
      Success()
    end
  end
end
