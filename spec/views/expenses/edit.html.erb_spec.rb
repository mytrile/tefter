require 'spec_helper'

describe "/expenses/edit" do
  before(:each) do
    render 'expenses/edit'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/expenses/edit])
  end
end
