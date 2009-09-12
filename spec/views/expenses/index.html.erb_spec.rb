require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/expenses/index" do
  def self.it_should_show_expense_for_month(month, amount)
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
        row.should have_tag('td', /#{category}/)
          row.should have_tag('td.price', /#{'%0.2f'% amount}/)
      end
    end
  end

  before(:each) do
    assigns[:expense] = stub_model(Expense).as_new_record
    assigns[:expenses] = [ stub_model(Expense, :category => stub_model(Category), :amount => 1000) ]
    assigns[:totals] = { Date.today => 1000 }
    assigns[:stats] = ActiveSupport::OrderedHash.new.tap do |h|
      h['July'] = { "Booze" => 2000, "Blaze" => 900 }
      h['June'] = { "Food" => 1000, "Health" => 1100 }
      h['May'] =  { "Food" => 600, "Bills" => 500 }
    end
    render 'expenses/index'
  end

  it { should respond_with(:success) }

  it_should_show_expense_for_month 'July', 2900 do |table|
    it_should_display_expense_for_category(table, 'Booze', 2000)
    it_should_display_expense_for_category(table, 'Blaze', 2000)
  end

  it_should_show_expense_for_month 'June', 2100 do |table|
    it_should_display_expense_for_category(table, 'Food', 1000)
    it_should_display_expense_for_category(table, 'Health', 1100)
  end

  it_should_show_expense_for_month 'May', 1100 do |table|
    it_should_display_expense_for_category(table, 'Food', 600)
    it_should_display_expense_for_category(table, 'Bills', 500)
  end

end
