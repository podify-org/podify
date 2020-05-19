module Downloads
  class FileUploader < Shrine
    plugin :download_endpoint, prefix: 'download',
                               host: Rails.application.routes.default_url_options[:host],
                               disposition: 'attachment'
    plugin :determine_mime_type, analyzer: :mimemagic
  end
end
