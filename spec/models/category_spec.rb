
require 'spec_helper'

describe Category do
  it { should belong_to :user }
  it { should have_many :expenses }
end
