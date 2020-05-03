class DownloadPresenter < ApplicationPresenter
  forward_or_nil(
    :size,
    to: :file
  )

  def format
    file.extension
  end

  private

  def file
    @file ||= FilePresenter.new(path)
  end
end
