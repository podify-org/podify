module Broadcasts
  class ApplicationBroadcast
    private

    def server
      ActionCable.server
    end

    def broadcast(channel, payload)
      server.broadcast(channel, payload)
    end
  end
end
