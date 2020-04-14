module Sources
  class Destroy
    include Dry::Monads[:result, :do]

    include Podify::Import[destroy_download: 'downloads.destroy']

    def call(source)
      DB.transaction do
        yield destroy_downloads(source.downloads)
        source.destroy
      end
      Success()
    end

    def destroy_downloads(downloads)
      downloads.each do |download|
        yield destroy_download.call(download)
      end
      Success()
    end
  end
end
