require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to("/")
    session['user_id'].should == assigns['user'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_user).returns(User.first)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when user is invalid" do
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when user is valid" do
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to("/")
  end

  it "show action should render profile page" do
    user = User.last
    User.stubs(:find).returns(user)
    get :show, :id => "1"
    assigns(:user).should == user
    assigns(:tweets).should == user.tweets
    response.should be_success
  end

  it "home action should render home page for current user" do
    @controller.stubs(:current_user).returns(User.first)
    get :home
    assigns(:tweets).should == Tweet.all
    response.should be_success
  end

  it "home action should redirect to login page when not logged in" do
    get :home
    response.should redirect_to(login_url)
  end

  it "tweet action should add a tweet and return saved status as json" do
    @controller.stubs(:current_user).returns(User.first)
    tweet = Tweet.new
    Tweet.stubs(:new).returns(tweet)
    tweet.stubs(:save).returns(true)
    post :tweet, :id => 1, :tweet => {:text => "this is a tweet"}
    response.should be_success
    response.body.should == "true"
  end
end
