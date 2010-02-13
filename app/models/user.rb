class User < ActiveRecord::Base
  acts_as_authentic
  has_many :expenses, :dependent => :destroy, :order => "created_at desc"
  has_many :categories, :dependent => :destroy
end
