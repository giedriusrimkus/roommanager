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
  	if @room.save
  		flash[:success] = "Room Created"
  		redirect_to @room
  	else
  		flash[:danger] = "Error occured"
  		render 'new'
  	end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:success] = "Room details updated"
      redirect_to @room
    else
      flash[:danger] = "Error updating room details!"
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:success] = "Room deleted"
    redirect_to products_path
  end

  def join
    @room = Room.find(params[:id])
    current_user.rooms << @room
    current_user.save
    flash[:success] = "Joined #{@room.name}!"
    redirect_to @room
  end

  def leave
    @room = Room.find(params[:id])
    current_user.rooms.delete(@room)
    current_user.save
    flash[:info] = "Left #{@room.name}"
    redirect_to current_user
  end


	private

		def room_params
			params.require(:room).permit(:name, :description)
		end

end