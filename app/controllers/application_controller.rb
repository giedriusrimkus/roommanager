class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	include SessionsHelper

	private
	
	  def logged_in_user
	      	unless logged_in?
	      		store_location
		        flash[:danger] = "Please log in."
		        redirect_to login_url
	      	end
    	end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		# user.toggle!(:admin)

		def admin_user
			redirect_to(root_url) unless current_user.admin?
			flash[:danger] = "Access is denied."
		end

end
