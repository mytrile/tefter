require 'spec_helper'

describe ApplicationController do

  class DummiesController < ApplicationController
    before_filter :require_user, :only => :index
    before_filter :require_no_user, :only => :new

    def index
    end

    def new
    end
  end

  controller_name :dummies

  describe "get action that requires user (not being signed in)" do
    before { UserSession.should_receive(:find).and_return(nil) }

    before do
      get 'index'
    end

    it { should redirect_to sign_in_path }
    it { should set_the_flash }
  end

  describe "get action that requires user (being signed in)" do
    before { UserSession.should_receive(:find).and_return(stub(UserSession, :user => user)) }

    before do
      get 'index'
    end

    it { should respond_with :success }
  end

  describe "get action that requires no user (not being signed in)" do
    before { UserSession.should_receive(:find).and_return(nil) }

    before do
      get 'new'
    end

    it { should respond_with :success }
  end

  describe "get action that requires no user (being signed in)" do
    before { UserSession.should_receive(:find).and_return(stub(UserSession, :user => user)) }

    before do
      get 'new'
    end

    it { should redirect_to root_path }
    it { should set_the_flash }
  end
end
