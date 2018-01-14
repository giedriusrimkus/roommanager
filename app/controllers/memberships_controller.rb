class MembershipsController < ApplicationController

	before_action :logged_in_user
	before_action :admin_user, only: [:index]

	def index
		@memberships = Membership.all
	end

	# def create
	# 	@room = Room.find(params[:room_id])
	# 	current_user.join(@room)
	# 	if current_user.save
	# 		flash[:success] = "Joined #{@room.name}!"
	# 	else
	# 		flash[:danager] = "Error has occured"
	# 	end
	# 	redirect_to root_path
	# end

	def new
		@membership = Membership.new
	end

	def create
		@membership = current_user.memberships.create!		
		@membership.save
		flash[:success] = "Membership Created"
	end

	# def create
 #  	@room = Room.new(room_params)
 #    current_user.rooms << @room
 #  	if @room.save
 #  		flash[:success] = "Room Created"
 #  		redirect_to root_path
 #  	else
 #  		render 'new'
 #  	end
 #  end

	# def destroy
	# 	@room = current_user.rooms.find(params[:room_id])
	# 	current_user.leave(@room)
	# 	if current_user.save
	# 		flash[:info] = "Left #{@room.name}"
	# 	else
	# 		flash[:danager] = "Error has occured"
	# 	end
	# 	redirect_to root_path
	# end

	def destroy
		@membership = room.memberships.first
		@membership.destroy
		flash[:info] = "Membership deleted"
		redirect_to root_path
	end

	private

	def membership_params
		params.require(:room).permit(:user_id, :room_id)
	end

	# def destroy
 #    @room = Room.find(params[:id])
 #    @room.destroy
 #    flash[:info] = "Room deleted"
 #    redirect_to root_path
 #  end

end
