module Sources
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
      destroy_download: 'downloads.destroy',
      destroy_request: 'requests.destroy',
    ]

    def call(source)
      DB.transaction do
        yield destroy_requests(source.requests)
        yield destroy_downloads(source.downloads)
        source.destroy
      end
      events.publish('sources.destroyed', source: source)
      Success()
    end

    def destroy_downloads(downloads)
      downloads.each do |download|
        yield destroy_download.call(download)
      end
      Success()
    end

    def destroy_requests(requests)
      requests.each do |request|
        yield destroy_request.call(request)
      end
      Success()
    end
  end
end
