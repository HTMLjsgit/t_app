class UsersController < ApplicationController
  helper_method :non_count
  helper_method :get_to_user

  def get_to_user(user_id, room_id)
    create_user_id = nil
    ret = nil
    UserRoom.where(room_id: room_id).find_each do | user_room |
      create_user_id = user_room.user_id
      if user_room.user_id == current_user.id
        ret = User.where(id: user_room.to_user_id).first
      else
        ret = User.where(id: user_room.user_id).first
      end
    end

    # 相手が部屋を作成した(user_rooms.user_id(部屋作成者)が相手) かつ メッセージが来ていない場合（chat_posts0件）はnilを返す（メッセージ一覧非表示）
    if create_user_id != current_user.id and ChatPost.where(room_id: room_id).count == 0
      return nil
    else
      return ret
    end
  end

  def non_count(user_id, room_id)
    ChatPost.where.not(:user_id => user_id).where(:see => 0).where(:room_id => room_id).count
  end

  def index
    @search = User.ransack(params[:q])
    @users = @search.result
  end

  def show
    @user = User.find(params[:id])
    @room = Room.new
    @rooms = current_user.rooms
    @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
    ids = [params[:id], current_user.id]
    @create_room = UserRoom.where(:user_id => ids).where(:to_user_id => ids).first
    @user_room_rels_count = 0
    user_room_rels = UserRoom.where(:user_id => current_user.id).or(UserRoom.where(:to_user_id => current_user.id))
    user_room_rels.find_each do | user_room_rel |
      @user_room_rels_count += ChatPost.where.not(:user_id => current_user.id).where(:see => 0).where(:room_id => user_room_rel.room_id).count
    end
  end

  def show_following
    @user = User.find(params[:id])
  end

  def show_follower
    @user = User.find(params[:id])
  end

  def chat_index
    # @to_users = nil
    room_ids = []
    room_rels = UserRoom.where(user_id: current_user.id).or(UserRoom.where(to_user_id: current_user.id)).find_each do | room_rel |
      unless room_ids.include?(room_rel.room_id)
        room_ids.push(room_rel.room_id)
      end
      # if room_rel.user_id == current_user.id
      #   ids.push(room_rel.to_user_id)
      # else
      #   ids.push(room_rel.user_id)
      # end
    end
    @rooms = Room.where(:id => room_ids)
  end

  def avater_update
    if params[:user] and avater = params[:user][:avater]
      @user = User.find(current_user.id)
      @user.avater.attach(avater)
    end
    redirect_to "/users/edit"
  end
end
