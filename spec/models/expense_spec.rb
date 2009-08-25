require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:category_name) }

  it "creates category if none present" do
    ex = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
    ex.category.name.should == "Booze"
  end

  it "reuses category if present" do
    ex1 = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
    ex2 = Expense.create :title => "Lagavulin", :amount => 30, :category_name => "Booze"
    ex1.category.should == ex2.category
  end

  it "is case insensitive for cat" do
    ex1 = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "booze"
    ex2 = Expense.create :title => "Lagavulin", :amount => 30, :category_name => "bOOze"
    ex1.category.should == ex2.category
  end


  it "defaults to today" do
    ex = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
    ex.created_at.should == Date.today
  end

  it "calculates totals" do
    Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
    Expense.create :title => "Talisker 18 yrs old", :amount => 50, :category_name => "Booze"
    Expense.create :title => "Talisker 18 yrs old", :amount => 50, :category_name => "Booze", :created_at => Date.yesterday
    records, totals = Expense.in_pages_with_totals :page => 1
    totals[Date.today].should == 90
    totals[Date.yesterday].should == 50
    records.should have(3).records
  end
  
  it "does not crate category if invalid" do
    ex = Expense.create :amount => 40, :category_name => "Booze"
    ex.should_not be_valid
    ex.category.should be_nil
  end

  context "stats" do
    before do
      @ex = Expense.create :title => "Talisker 18 yrs old", :amount => 40, :category_name => "Booze"
      @month = @ex.created_at.strftime('%B')
      @stats = Expense.stats
    end

    it "should provide stats for months" do
      @stats.keys.should include(@month)
    end

    it "should return correct sum for category" do
      @stats[@month][@ex.category.name].should == 40
    end
    
    
  end

end
