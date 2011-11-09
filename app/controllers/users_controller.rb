class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show]

  def home
    @tweets = Tweet.paginate(:per_page => 20, :page => params[:page])
    @tweet = Tweet.new
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(:per_page => 20, :page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end

  def tweet
    tweet = Tweet.new(:user => current_user, :text => params[:tweet][:text])
    flash[:notice] = "Tweet posted." if tweet.valid?
    render :text => tweet.save
  end
end
