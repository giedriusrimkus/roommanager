class AccountActivationsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by(email: params[:account_activation][:email].downcase)
		if @user 
			if @user.activated?
				redirect_to login_path
				flash[:info] = "User is already activated. Please log in."
			else
				# @user.create_activation_digest
				@user.resend_activation_email
				flash[:info] = "Activation email re-sent. Please check your email for activation link."
				redirect_to root_url
			end
		else
			flash.now[:danger] = "There was no account found for your e-mail address."
			render 'new'
		end
	end
		
	
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:success] = "<strong>Success!</strong> Account activated!"
			redirect_to root_url
		else
			flash[:danger] = "<strong>Error!</strong> Invalid activation link!"
			redirect_to root_url
		end
	end

	def resend_activation
		@user = User.find_by(email: params[:email])
		@user.resend_activation_email
		flash[:info] = "Activation email re-sent. Please check your email for activation link."
		redirect_to root_url
	end

end
