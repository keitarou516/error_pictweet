class TweetsController < ApplicationController
  
  before_action :move_to_index
  
  def index
    @twets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end
  
  def new
    
  end
  
  def create
    Tweet.create(text: tweet_params[:text], image: tweet_params[:image],user_id: current_user.id)
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end
  
  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(image: params[:image],text: tweet_params[:text])
    end
  end

  
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end
  
  private
  def tweet_params
    params.permit(:taxt, :image)
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end