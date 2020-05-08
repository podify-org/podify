class DownloadPresenter < ApplicationPresenter
  forward_or_nil(
    :size,
    to: :file
  )

  def format
    file.extension
  end

  def description
    fetcher_information['description']
  end

  def download_url
    Rails.application.routes.url_helpers.serve_source_download_url(object.source, object)
  end

  private

  def file
    @file ||= FilePresenter.new(path)
  end
end
