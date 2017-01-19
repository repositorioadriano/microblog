class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweet = Tweet.new
    @tweets = Tweet.where(:user_id => current_user.id).order("created_at DESC").limit(15)
  end

  def show
    @tweet = Tweet.new
    @tweets = User.find_by(user_name: params[:user_name]).tweets.order('created_at DESC')
    @user = User.find_by(user_name: params[:user_name])
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path}
      else
        @feed_items = []
        render 'tweets/feed'
      end
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message, :user_id, :image)
  end
end
