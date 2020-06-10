xml.instruct! :xml, version: "1.0"

xml.rss(
  version: "2.0",
  "xmlns:content"  => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:wfw"      => "http://wellformedweb.org/CommentAPI/",
  "xmlns:dc"       => "http://purl.org/dc/elements/1.1/",
  "xmlns:atom"     => "http://www.w3.org/2005/Atom",
  "xmlns:slash"    => "http://purl.org/rss/1.0/modules/slash/",
  "xmlns:itunes"   => "http://www.itunes.com/dtds/podcast-1.0.dtd",
) do

  xml.channel do
    xml.atom :link, rel: "self", href: request.url, type: "application/rss+xml"
    xml.link feed_url
    xml.itunes :image, href: asset_pack_url('media/logo/square.png')
    xml.lastBuildDate Time.now.rfc822
    xml.language "en-US"
    xml.generator root_url

    xml.title "Podify: #{feed.name}"
    xml.author "Podify"
    xml.description "Your downloads on Podify"

    sources.each do |source|
      xml.item do
        xml.title source.display_title
        xml.link source.url
        xml.pubDate source.created_at.rfc822
        xml.guid "podify-#{feed.id}-#{source.id}", isPermaLink: false

        desc =
          xml.description do
            xml.cdata! <<~EOF
              <p>From #{link_to source.url, source.url}</p>
              <p>#{source.description}</p>
            EOF
          end

        xml.itunes :summary, source.description

        xml.itunes :author, source.author
        xml.itunes :image, href: source.thumbnail_url
        # xml.itunes :duration, item.duration

        if source.last_download
          file = source.last_download.file
          xml.enclosure url: file.download_url, length: file.size, type: file.mime_type
        end
      end
    end
  end

end
