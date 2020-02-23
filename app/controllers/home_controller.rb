class HomeController < ApplicationController
  def top
  	flash[:logout] = "Signed out successfully."
  end

  def about
  end
end
