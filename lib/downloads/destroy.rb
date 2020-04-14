module Downloads
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[
      'events',
    ]

    def call(download)
      download.destroy
      events.publish('downloads.destroyed', download: download)
      Success()
    end
  end
end
