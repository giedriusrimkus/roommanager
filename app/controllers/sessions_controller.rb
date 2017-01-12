class SessionsController < ApplicationController
 
  def new
  end

  def create
	user = User.find_by(email: params[:session][:email].downcase)
	if user && user.authenticate(params[:session][:password])
		if user.activated?
			log_in user
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			flash[:success] = 'Welcome back!'
			redirect_back_or root_path
		else
			message = "<strong>Account not activated. </strong>"
			message += "Check your email for the activation link or "
			message += " #{view_context.link_to "resend activation email", { action: "resend_activation",
                controller: "account_activations", email: user.email }, method: :post}"
			flash[:warning] = message
			redirect_to root_url
		end
	else
		flash.now[:danger] = 'Invalid email/password combination'
		render 'new'
	end
  end

  def destroy
	log_out if logged_in?
  	flash[:info] = 'Logged Out'
    redirect_to root_url
  end

end
