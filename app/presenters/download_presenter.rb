class DownloadPresenter < ApplicationPresenter
  def format
    Pathname(path).extname[1..-1]
  end
end
