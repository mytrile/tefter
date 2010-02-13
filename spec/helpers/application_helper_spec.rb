require 'spec_helper'

describe ApplicationHelper do

  context "friendly date" do
    it "should display today when date is today" do
      helper.friendly_date(Date.today).should == "today"
    end
    it "should display yesterday when date is yesterday" do
      helper.friendly_date(Date.yesterday).should == "yesterday"
    end
  end

end
