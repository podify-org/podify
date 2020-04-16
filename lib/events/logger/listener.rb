module Events
  class Logger
    class Listener
      include Podify::Import['events.logger']

      def respond_to_missing?(method, *)
        method.to_s.start_with?('on_')
      end

      def method_missing(method, event)
        logger.log_event(event)
      end
    end
  end
end
