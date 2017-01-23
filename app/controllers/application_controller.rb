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
			@user = User.friendly.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		# user.toggle!(:admin)

		def admin_user
			unless current_user.try(:admin?)
				flash[:danger] = "Access is denied."
				redirect_to(root_url)
			end
		end

		def correct_or_admin_user
			@user = User.friendly.find(params[:id])
			unless current_user?(@user) || current_user.try(:admin?)
				flash[:danger] = "Access is denied."
				redirect_to(root_url)
			end
		end


end
