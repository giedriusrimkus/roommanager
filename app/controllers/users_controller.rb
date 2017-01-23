class UsersController < ApplicationController

	before_action :logged_in_user, except: [:new, :create]
	before_action :correct_or_admin_user, only: [:edit, :update, :cancel_account]
	before_action :admin_user,     only: [:destroy, :index, :activate, :deactivate]


	def show
		@user = User.friendly.find(params[:id])
		# @products = @user.products.paginate(page: params[:page])
		# debugger
	end

	def index
		@users = User.all.order('created_at DESC').paginate(page: params[:page])
	end


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Account created. Please check your email to activate your account."
			redirect_to root_url
		else
			render 'new'
		end
	end

	def edit
		@user = User.friendly.find(params[:id])
	end

  	def update
  		@user = User.friendly.find(params[:id])
  		if @user.update_attributes(user_params)
			flash[:success] = "User details updated!"
			redirect_to @user
		else
			render 'edit'
		end
  	end

	def destroy
		User.friendly.find(params[:id]).destroy
		flash[:info] = "User deleted"
		redirect_to users_url
	end

	def cancel_account
		@user = User.friendly.find(params[:id])
		@user.destroy
		flash[:info] = "Your account has been removed!"
		redirect_to root_url
	end

	def activate
		@user = User.friendly.find(params[:id])
		@user.activate
		@user.save
		flash[:success] = "User activated!"
		redirect_to users_url
	end

	def deactivate
		@user = User.friendly.find(params[:id])
		@user.deactivate
		@user.save
		flash[:success] = "User de-activated!"
		redirect_to users_url
	end


	private

	    def user_params
	      params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
	    end

end
