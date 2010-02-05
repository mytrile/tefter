class HomeController < ApplicationController

  def index
    redirect_to new_expense_path if signed_in? 
  end

end
