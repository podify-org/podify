module Downloads
  class FileUploader < Shrine
    plugin :download_endpoint, prefix: 'download',
                               host: Rails.application.routes.default_url_options[:host],
                               disposition: 'attachment'
    plugin :determine_mime_type, analyzer: :mimemagic

    def generate_location(io, record: nil, **context)
      [
        'downloads',
        sanitize_filename(record.author.presence || 'no_author'),
        sanitize_filename(context[:metadata]['filename']),
      ].join('/')
    end

    private

    def sanitize_filename(name)
      name.strip.gsub(/[^0-9A-Za-z.\-]+/, '_')
    end
  end
end
