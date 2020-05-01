module Events
  class Publisher
    include Dry::Events::Publisher[:podify]

    register_event('requests.created')
    register_event('requests.destroyed')

    register_event('sources.created')
    register_event('sources.destroyed')

    register_event('downloads.created')
    register_event('downloads.destroyed')

    register_event('downloader.fetch_source.fetched')
  end
end
