require 'spec_helper'

describe Tweet do

  def new_tweet(attributes = {})
    attributes[:text] ||= "tweet"
    attributes[:user] ||= User.new
    Tweet.new(attributes)
  end

  it "should be valid" do
    new_tweet.should be_valid
  end

  it "should validate the presence of user" do
    tweet = new_tweet
    tweet.user = nil
    tweet.should have(1).error_on(:user)
  end

  it "should validate the presence of text" do
    new_tweet(:text => "").should have(1).error_on(:text)
  end

  it "should be less than or equal to 140 characters" do
    new_tweet(:text => "a"*141).should have(1).error_on(:text)
  end
end
