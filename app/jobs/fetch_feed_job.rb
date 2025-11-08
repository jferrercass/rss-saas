class FetchFeedJob < ApplicationJob
  queue_as :fetches
    
  def perform(feed_id)
  feed = Feed.find(feed_id)
  begin
    # Try to detect native RSS first
    parsed = Feedjira.parse(HTTParty.get(feed.url).body)
    
    
    if parsed.nil? || parsed.entries.empty?
      # Fallback: simple html scraping
      html = HTTParty.get(feed.url).body
      doc = Nokogiri::HTML(html)
    # Very basic heuristic: collect links with time or article selectors
      doc.css('a').first(10).each do |a|
      # store as item placeholder
      feed.items.create_with(title: a.text.strip, link: a['href'], fetched_at: Time.current).find_or_create_by(guid: Digest::SHA1.hexdigest(a['href'].to_s))
      end
    else
      parsed.entries.each do |entry|
      guid = entry.id || entry.url || Digest::SHA1.hexdigest(entry.title.to_s + entry.published.to_s)
      feed.items.create_with(
      title: entry.title,
      link: entry.url || entry.entry_id,
      content: entry.summary || entry.content || '',
      published_at: entry.published
      ).find_or_create_by(guid: guid)
    end
  end
  
  
  feed.update(status: :active, last_fetched_at: Time.current)
  rescue => e
  Rails.logger.error("FetchFeedJob failed for feed=#{feed.id}: #{e.message}")
  f eed.update(status: :error)
  end
end