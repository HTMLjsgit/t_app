class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find, only: [:index, :create]
  before_action :room_find, only: [:show]
  # before_action :user_rooms_attach, only: [:create]

  before_action :userrooms_already_added?, only: [:create]
  before_action :userrooms_admin_check, only: [:show]

  before_action :user_admin_check, only: [:index]
  def index
    @rooms = @user.rooms.includes(:users, :user_rooms, :chat_posts)
  end

  def show
    @room = Room.find(params[:id])
    @chat_posts = @room.chat_posts.includes(:user, :chat_post_read, :chat_post_images)
    #自分以外のメッセージすべてを既読済みにする
    no_mine_chat_posts = @room.chat_posts.where.not(user_id: current_user.id).includes(:chat_post_read)

    no_mine_chat_posts.joins(:chat_post_read).where(chat_post_reads: {read: false}).each do |target_chat_post|
      target_chat_post.chat_post_read.update!(read: true, user_id: current_user.id, room_id: @room.id)
    end

    # no_mine_chat_posts.joins(:chat_post_reads).where(chat_post_reads: {})
  end

  def create
    if current_user.id == @user.id
      #自分対自分のルームを作ろうとするならばリターンする。
      redirect_to root_path and return
    end
    @target_user = @user

    @room = Room.create!(name: "？")
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

  # def user_rooms_attach
  #   @user_rooms = UserRoom.where(user_id: [current_user.id, @user.id], room_id: room.id)
  # end

  def userrooms_already_added?
    #すでにUserRoomに入っているか？
    user_1_room_ids = current_user.user_rooms.pluck(:room_id)
    user_2_room_ids = @user.user_rooms.pluck(:room_id)
    room_check = user_1_room_ids & user_2_room_ids
    if room_check.size > 0
      redirect_to room_path(room_check[0])
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
