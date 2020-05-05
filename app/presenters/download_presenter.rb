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

  private

  def file
    @file ||= FilePresenter.new(path)
  end
end
