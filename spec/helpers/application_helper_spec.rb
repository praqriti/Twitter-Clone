require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  it "should return gravatar url for user" do
    gravatar_url(User.new(:email => "dummy@dummy.com")).should == "http://gravatar.com/avatar/1aedfd0a740a61d7b022b260651e2680.png?s=48"
  end
end
