require File.dirname(__FILE__) + '/../spec_helper'

describe Story do
  it "should be valid" do
    Story.new( :title => "A user can login" ).should be_valid
  end

  it "should be invalid without a title" do
    story = Story.new
    story.save
    story.errors_on(:title).include?("can't be blank").should be_true
  end

end
