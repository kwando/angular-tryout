class JmeForumController < ApplicationController
  layout :false
  def index
    respond_to do |f|
      f.json { render json: forum_data }
      f.html
    end
  end

  private
  def forum_data
    Rails.cache.fetch('jme_forum_data', expires_in: 60.seconds) do
      JME::ForumFetcher.new.fetch
    end
  end
end
