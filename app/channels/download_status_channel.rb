class DownloadStatusChannel < ApplicationCable::Channel
  def subscribed
    # TODO: authorize with pandit
    if current_user.sources_dataset[params[:source]]
      stream_from "sources/#{params[:source]}/download_status"
    else
      reject
    end
  end
end
