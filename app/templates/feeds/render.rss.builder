xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0",
  "xmlns:content"  => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:wfw"      => "http://wellformedweb.org/CommentAPI/",
  "xmlns:dc"       => "http://purl.org/dc/elements/1.1/",
  "xmlns:atom"     => "http://www.w3.org/2005/Atom",
  "xmlns:slash"    => "http://purl.org/rss/1.0/modules/slash/",
  "xmlns:itunes"   => "http://www.itunes.com/dtds/podcast-1.0.dtd",
  "xmlns:rawvoice" => "http://www.rawvoice.com/rawvoiceRssModule/" do

  xml.channel do
    xml.title "Podify: All"
    xml.atom :link, href: "bla", rel: "self", type: "application/rss+xml"
    # xml.link request.url
    xml.description "All your downloads on Podify"
    xml.lastBuildDate Time.now
    xml.language "en-US"
    xml.generator root_url

    sources.each do |source|
      xml.item do
        xml.title source.title.presence || "Bla" # source.display_title
        xml.link source.url
        xml.pubDate I18n.l(source.created_at, format: :rss)
        xml.guid "podify-all--#{source.id}", isPermaLink: false

        desc = <<~EOF
          <p>Source: #{link_to source.url, source_url(source.id)}</p>
        EOF
        xml.description { xml.cdata! desc }
        #xml.itunes :summary, desc

        # xml.itunes :author, 'Podify'
        # xml.itunes :image, href: item.image || item.feed.image
        # xml.itunes :duration, item.duration

        download = source.downloads.last
        if download
          file = Pathname(download.path)
          xml.enclosure url: "https://example.com#{file.to_s}", length: file.size, type: MimeMagic.by_path(file)
        end
      end
    end
  end

end
