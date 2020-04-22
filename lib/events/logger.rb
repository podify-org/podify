module Events
  class Logger
    include Podify::Import['events', 'logger']

    def subscribe
      events.subscribe self
    end

    def unsubscribe
      events.unsubscribe self
    end

    def respond_to_missing?(method, *)
      method.to_s.start_with?('on_')
    end

    private

    def method_missing(method, event)
      log_event(event)
    end

    def log_event(event)
      logger.debug event: {
        id: event.id,
        payload: clean_payload(event.payload),
      }
    end

    def clean_payload(payload)
      return payload unless payload.is_a?(Hash)

      payload.to_h do |k, v|
        v = v.id if v.is_a?(Sequel::Model)
        v = clean_payload(v)

        [k, v]
      end
    end
  end
end
