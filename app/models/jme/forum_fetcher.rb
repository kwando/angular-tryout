require 'net/http'
require 'uri'

module JME
class ForumFetcher
  FETCH_URL = URI.parse('http://jmonkeyengine.org/forum/latest-posts/')
  def initialize

  end

  def fetch
    response = Net::HTTP.get_response(FETCH_URL)
    parser = ForumParser.new
    parser.parse(response.body)
  end
end
end