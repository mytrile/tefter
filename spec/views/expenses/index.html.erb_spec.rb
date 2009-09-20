require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/expenses/index" do

  before(:each) do
    assigns[:expense] = stub_model(Expense).as_new_record
    assigns[:expenses] = [ ]
    assigns[:totals] = {  }
    assigns[:stats] = {  }
    template.stub! :will_paginate
  end

  context "- rendering" do
    before { render 'expenses/index' }
    it { should respond_with(:success) }
  end

  context "- statistics" do

    before(:each) do
      assigns[:stats] = ActiveSupport::OrderedHash.new.tap do |h|
        booze =   stub_model(Category, :name => "Booze")
        blaze =   stub_model(Category, :name => "Blaze")
        food =    stub_model(Category, :name => "Food")
        health =  stub_model(Category, :name => "Health")
        bills =   stub_model(Category, :name => "Bills")
        h['July'] = { booze => 2000, blaze => 900 }
        h['June'] = { food => 1000, health => 1100 }
        h['May'] =  { food => 600, bills => 500 }
      end
      render 'expenses/index'
    end

    def self.it_should_display_expense_for_month(month, amount)
      it "should display #{amount} for #{month}, given the sample data" do
        response.should have_tag("table[summary~=#{month}]") do |table|
          table.should have_tag('thead') do |head|
            head.should have_tag('th', /#{month}/)
              head.should have_tag('th.price', /#{'%0.2f'% amount}/)
          end

          table.should have_tag('tbody') do |tbody|
            yield(tbody)
          end
        end
      end
    end

    def self.it_should_display_expense_for_category(month, category, amount)
      it "should display #{amount} for #{category}" do
        month.should have_tag('tr') do |row|
          row.should have_tag('a', :content => category)
          row.should have_tag('td.price', /#{'%0.2f'% amount}/)
        end
      end
    end

    it_should_display_expense_for_month 'July', 2900 do |table|
      it_should_display_expense_for_category(table, 'Booze', 2000)
      it_should_display_expense_for_category(table, 'Blaze', 2000)
    end

    it_should_display_expense_for_month 'June', 2100 do |table|
      it_should_display_expense_for_category(table, 'Food', 1000)
      it_should_display_expense_for_category(table, 'Health', 1100)
    end

    it_should_display_expense_for_month 'May', 1100 do |table|
      it_should_display_expense_for_category(table, 'Food', 600)
      it_should_display_expense_for_category(table, 'Bills', 500)
    end
  end

  it "should display pagination" do
    template.should_receive(:will_paginate).with(assigns[:expenses])
    render "expenses/index"
  end

  context "- categories" do
    before(:each) do
      @category = stub_model(Category, :name => "Booze")
      @expense = stub_model(Expense, :category => @category, :amount => 50)
      assigns[:expenses] = [ @expense ]
      assigns[:category] = @category
      render "expenses/index"
    end

    it "should render link to expense category" do
      response.should have_selector "a", :href => category_expenses_path(@category), :content => "Booze"
    end

    it "should render category title" do 
      response.should have_text /Expenses marked as Booze/
    end
  end

end
