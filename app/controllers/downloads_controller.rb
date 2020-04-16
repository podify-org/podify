class DownloadsController < ApplicationController
  schema(:serve) do
    required(:id).value(:integer)
    required(:source_id).value(:integer)
  end

  def serve
    send_file(download.path, type: MimeMagic.by_path(download.path))
  end

  private

  def source
    Source.with_pk!(safe_params[:source_id])
  end

  def download
    source.downloads_dataset.with_pk!(safe_params[:id])
  end
end
