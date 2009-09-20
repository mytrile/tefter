require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  it { should have_many :expenses }

  it "should cleanup empty categories" do
    @cat1 = Factory(:category)
    @cat2 = Factory(:category)
    Factory(:expense, :category => @cat1)
    Category.cleanup!

    Category.all.should == [ @cat1 ]

  end
end
