module JME
module Forum
class Topic
  include Virtus
  attribute :title,         String
  attribute :author,        String
  attribute :posts,         Fixnum, default: 1
  attribute :voices,        Fixnum, default: 1
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

  def diversity
    posts.to_f/voices
  end

  def to_json
    attributes.to_json
  end
end
end
end