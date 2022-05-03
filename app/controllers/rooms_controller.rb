class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find, only: [:index, :create]
  before_action :room_find, only: [:show]

  before_action :userrooms_already_added?, only: [:create]

  before_action :userrooms_admin_check, only: [:show]

  before_action :user_admin_check, only: [:index]
  def index
    @rooms = @user.rooms
  end
  def show
    @room = Room.find(params[:id])
    @chat_posts = @room.chat_posts.includes(:user)

  end

  def create
    if current_user.id == @user.id
      #自分対自分のルームを作ろうとするならばリターンする。
      redirect_to root_path and return
    end
    @target_user = @user
    @room = Room.new
    @room.save
    [current_user.id, @target_user.id].each do |add_user_id|
      @room.user_rooms.create!(user_id: add_user_id)
    end
    redirect_to @room
  end

  private
  def room_params
    params.require(:room).permit(:name)
  end

  def userrooms_admin_check
    if !current_user.user_rooms.where(room_id: @room.id).exists? && !current_user.admin?
      redirect_to root_path and return
    end
  end

  def userrooms_already_added?
    #すでにUserRoomに入っているか？
    if UserRoom.where(user_id: @user.id).where(user_id: current_user.id).exists?

    end
  end

  def user_find
    @user = User.find params[:user_id]
  end

  def room_find
    @room = Room.find params[:id]
  end
  def user_admin_check
    if @user.id != current_user.id && !current_user.admin?
      redirect_to root_path and return
    end
  end
end
