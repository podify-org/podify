module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = helpers.current_user
    end

    private

    class Helpers
      extend Dry::Initializer
      option :request
      include Devise::Controllers::Helpers
    end

    def helpers
      @helpers ||= Helpers.new(request: request)
    end
  end
end
