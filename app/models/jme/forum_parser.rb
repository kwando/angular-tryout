require 'nokogiri'

class JME::ForumParser
  def parse html
    doc   = Nokogiri::HTML.parse(html)
    bbp   = doc.search('#bbpress-forums .bbp-body').first
    posts = bbp.search('ul').map do |post|
      lis = post.search('li')

      ::JME::Forum::Topic.new({
                         title:         lis[0].search('.bbp-topic-permalink').first.content,
                         author:        lis[0].search('.bbp-author-name').first.content,
                         permalink:     lis[0].search('.bbp-topic-permalink').first['href'],
                         posts:         lis[1].content,
                         voices:        lis[2].content,
                         last_post_by:  lis[3].search('.bbp-author-name').first.content,
                         support_topic: lis[0].search('.bbp-st-topic-support').first.try { |s| s.content.strip.match(/\[(.*?)\]/)[1].downcase },
                         avatar_url:    lis[0].search('.avatar').first['data-lazy-src']
                       })
    end

    return posts
  end
end