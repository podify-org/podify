module Events
  class Publisher
    include Dry::Events::Publisher[:podify]

    register_event('sources.created')
    register_event('sources.destroyed')
    register_event('downloads.created')
    register_event('downloads.destroyed')
  end
end
