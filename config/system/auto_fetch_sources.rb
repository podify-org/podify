Dry::Rails.container do
  boot(:auto_fetch_sources) do
    start do
      Podify::Container['events'].subscribe 'sources.created' do |event|
        Podify::Container['downloader.fetch_source_job'].perform_async(event[:source].id)
      end
    end
  end
end
