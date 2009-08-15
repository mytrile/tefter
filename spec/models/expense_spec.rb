require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Expense do
  it { should belong_to :category }
  it { should validate_presence_of :title }
  it { should validate_presence_of :amount }
end
