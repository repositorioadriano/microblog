class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @tweet  = current_user.tweets.build
      @feed_items = current_user.feed.order('created_at DESC')
    end
  end

  def index
  end
end
