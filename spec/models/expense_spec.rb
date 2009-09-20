require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:category_name) }

  context "on create" do
    it "should create a new category if none present with the same name" do
      ex = Factory(:expense, :category_name => "Booze")
      ex.category.name.should == "Booze"
    end

    it "should reuse category if it is already present" do
      ex1 = Factory(:expense, :category_name => "Booze")
      ex2 = Factory(:expense, :category_name => "Booze")
      ex1.category.should == ex2.category
    end

    it "should be case insensitive for category name" do
      ex1 = Factory(:expense, :category_name => "bOOze")
      ex2 = Factory(:expense, :category_name => "Booze")
      ex1.category.should == ex2.category
    end

    it "should set created on to today by default" do
      ex = Factory(:expense)
      ex.created_at.should == Date.today
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

  context "- day totals" do
    before do
      Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
      Expense.create :title => "Talisker 18 yrs old", :amount => 50, :category_name => "Booze"
      Expense.create :title => "Talisker 18 yrs old", :amount => 50, :category_name => "Booze", :created_at => Date.yesterday
      @records, @totals = Expense.in_pages_with_totals :page => 1
    end

    it "should calculate totals for today correctly" do
      @totals[Date.today].should == 90
    end

    it "should calculate totals for yesterday correctly" do
      @totals[Date.yesterday].should == 50
    end

    it "should provide correct number of records" do
      @records.should have(3).records
    end
  end
  
  context "statistics" do
    before do
      Time.stub!(:now).and_return(Time.parse '13 August 2009')
      @talisker = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
      Time.stub!(:now).and_return(Time.parse '29 July 2009')
      @lagavulin = Expense.create :title => "Lagavilin Distillers Edition", :amount => 80, :category_name => "Booze"
      @this_month = @talisker.created_at.strftime('%B')
      @last_month = @lagavulin.created_at.strftime('%B')
      @stats = Expense.stats
    end

    it "should provide statistics for this month" do
      @stats.keys.should include(@this_month)
      @stats[@this_month][Category.find_by_name('Booze')].should == 40
    end

    it "should provide statistics for last month" do
      @stats.keys.should include(@last_month)
      @stats[@last_month][Category.find_by_name('Booze')].should == 80
    end
  end

  context "with parent category" do
    it "should default category name if parent present" do
      category = Factory(:category)
      category.expenses.new.category_name.should == category.name
    end
  end



end
