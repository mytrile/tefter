require 'spec_helper'

describe Expense do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should validate_presence_of :title }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :category_name }

  context "on create" do

    let :user do
      Factory(:registered_user)
    end

    it "should create a new category if none present with the same name" do
      ex = Factory(:expense, :category_name => "Booze")
      ex.category.name.should == "Booze"
    end

    it "should reuse category if it is already present" do
      ex1 = Factory(:expense, :category_name => "Booze", :user => user)
      ex2 = Factory(:expense, :category_name => "Booze", :user => user)
      ex1.category.should == ex2.category
    end

    it "should be case insensitive for category name" do
      ex1 = Factory(:expense, :category_name => "bOOze", :user => user)
      ex2 = Factory(:expense, :category_name => "Booze", :user => user)
      ex1.category.should == ex2.category
    end

    it "should not crate a new category if invalid" do
      ex = Expense.create :amount => 40, :category_name => "Booze" # invalid, no description.
      ex.should_not be_valid
      ex.category.should be_nil
    end

    it "should update its category" do
      ex = Factory(:expense, :category_name => "Booze")
      ex.update_attributes! :category_name => "Blaze"
      ex.reload
      ex.category.name.should == "Blaze"
    end
  end

end
