class DownloadPresenter < ApplicationPresenter
  forward_or_nil(
    :size,
    :human_size,
    :download_url,
    :mime_type,
    to: :file
  )

  def format
    file.extension
  end

  def description
    fetcher_information['description']
  end

  def file
    @file ||= FilePresenter.wrap(object.file)
  end
end
