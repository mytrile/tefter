class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :assign_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for signing up!"
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect_to user_path
    else
      render :action => :edit
    end
  end

  protected
  def assign_user
    @user = current_user # makes our views "cleaner" and more consistent
  end
end

