module Tefter
  module Stubs
    def self.let(name, &block)
      define_method name do
        @assignments ||= {}
        @assignments[name] ||= instance_eval(&block)
      end
    end

    let :new_user do
      mock_model(User, :errors => stub_errors, :null_object => true).as_new_record
    end

    let :new_user_session do
      stub(UserSession, :null_object => true, :errors => stub_errors, :id => nil)
    end

    let :new_expense do
      stub_model(Expense).as_new_record
    end


    let :stub_errors do
      stub(ActiveRecord::Errors, :null_object => true, :count => 0)
    end

    let :user do
      mock_model(User, :expenses => stub(:count => 0))
    end

    let :category do
      stub_model(Category, :name => "Food")
    end

    let :expenses do
      WillPaginate::Collection.create(1, 30, 300) do |pager|
        pager.replace [ stub_model(Expense, :amount => 10, :created_on => Date.today, :category => category) ] * 30
      end
    end

  end
end

Spec::Runner.configure { |config| config.include Tefter::Stubs }
