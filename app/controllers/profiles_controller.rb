class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def index
    @user = User.new
    @users = User.all
  end

  def show
    @tweets = User.find_by(user_name: params[:user_name]).tweets.order('created_at DESC')
    @user = User.find_by(user_name: params[:user_name])
  end

  def following
    @user = current_user
    @users = @user.following
  end

  def followers
    @user = current_user
    @users = @user.followers
  end

  def edit

  end

  def update

  end
  def owned_profile
    @user = User.find_by(user_name: params[:user_name])
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:user_name])
   end
end
