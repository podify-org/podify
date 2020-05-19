class GarbageCollectionJob
  include Sidekiq::Worker

  sidekiq_options retry: false

  include Podify::Import[
    destroy_source: 'sources.destroy',
  ]

  def perform
    Source.without_requests.paged_each do |source|
      destroy_source.call(source)
    end
  end
end
