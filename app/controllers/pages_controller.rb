class PagesController < ApplicationController

  def home
	@product = current_user.products.build if logged_in?
  end

  def about
  end
end
