require 'open-uri'
require 'nokogiri'
require 'virtus'
require 'active_support/core_ext/object/try.rb'
require 'json'

cache_file = 'data-content.html'

url = 'http://jmonkeyengine.org/forum/latest-posts/'
content = open(url).read

content



class Post
  include Virtus
  attribute :title,         String
  attribute :author,        String
  attribute :posts,         Fixnum
  attribute :voices,        Fixnum
  attribute :last_post_by,  String
  attribute :avatar_url,    String
  attribute :permalink,     String
  
  attribute :support_topic, Boolean
  
  def support_topic?
    !support_topic.nil?
  end
  
  def resolved?
    support_topic == 'resolved'
  end
end

doc = Nokogiri::HTML.parse(content)
bbp = doc.search('#bbpress-forums .bbp-body').first
posts = bbp.search('ul').map do |post|
  lis = post.search('li')
 
  Post.new({
    title:          lis[0].search('.bbp-topic-permalink').first.content,
    author:         lis[0].search('.bbp-author-name').first.content,
    permalink:      lis[0].search('.bbp-topic-permalink').first['href'],
    posts:          lis[1].content,
    voices:         lis[2].content,
    last_post_by:   lis[3].search('.bbp-author-name').first.content,
    support_topic:  lis[0].search('.bbp-st-topic-support').first.try{|s| s.content.strip.match(/\[(.*?)\]/)[1].downcase },
    avatar_url:     lis[0].search('.avatar').first['data-lazy-src']
  })
end

puts posts.map(&:attributes).to_json

