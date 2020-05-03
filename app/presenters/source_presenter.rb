class SourcePresenter < ApplicationPresenter
  forward_or_nil(
    :title,
    :author,
    :thumbnail_url,
    :format,
    to: :last_download
  )

  def last_download
    return @last_download if defined?(@last_download)

    last = downloads_dataset.last
    @last_download = last && DownloadPresenter.new(last)
  end
end
