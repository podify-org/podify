module Broadcasts
  class DownloadStatus < ApplicationBroadcast
    extend Dry::Initializer
    option :source

    def broadcast(status)
      super(channel, source_id: source.id, status: status)
    end

    def call
      broadcast(DownloadStatusPresenter.wrap(source).for_broadcast)
    end

    def progress(progress)
      broadcast({ status: 'downloading', progress: progress })
    end

    def downloaded
      broadcast({ status: 'downloaded' })
    end

    def channel
      "sources/#{source.id}/download_status"
    end
  end
end
