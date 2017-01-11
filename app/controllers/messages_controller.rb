class MessagesController < ApplicationController

	def new
	    @message = Message.new
	end

	def create
		@message = Message.new(message_params)
	    
		if @message.valid?
			MessageMailer.new_message(@message).deliver
			flash[:success] = "Your message has been sent."
			redirect_to contact_path
		else
			flash[:alert] = "An error occurred while delivering this message."
			ender :new
		end
	end

	private

		def message_params
			params.require(:message).permit(:name, :email, :content)
		end

end
