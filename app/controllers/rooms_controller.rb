class RoomsController < ApplicationController

  def show
  	@room = Room.find(params[:id])

  end

  def index
  	@rooms = Room.all
  end

  def new
  	@room = Room.new
  end

   def create
  	@room = Room.new(room_params)
    current_user.rooms << @room
  	if @room.save
  		flash[:success] = "Room Created"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:success] = "Room details updated!"
      redirect_to root_path
    else
      flash[:danger] = "Error updating room details!"
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:info] = "Room deleted"
    redirect_to root_path
  end

  def join
    @room = Room.find(params[:id])
    current_user.rooms << @room
    current_user.save
    flash[:success] = "Joined #{@room.name}!"
    redirect_to root_path
  end

  def leave
    @room = Room.find(params[:id])
    current_user.rooms.delete(@room)
    current_user.save
    flash[:info] = "Left #{@room.name}"
    redirect_to root_path
  end


	private

		def room_params
			params.require(:room).permit(:name, :description)
		end

end
