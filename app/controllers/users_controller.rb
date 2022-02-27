class UsersController < ApplicationController
  helper_method :non_count
  helper_method :get_to_user

  def get_to_user(user_id, room_id)
    create_user_id = nil
    ret = nil
    UserRoom.where(room_id: room_id).find_each do | user_room |
      create_user_id = user_room.user_id
      if user_room.user_id == @user.id
        ret = User.where(id: user_room.to_user_id).first
      else
        ret = User.where(id: user_room.user_id).first
      end
    end

    # 相手が部屋を作成した(user_rooms.user_id(部屋作成者)が相手) かつ メッセージが来ていない場合（chat_posts0件）はnilを返す（メッセージ一覧非表示）
    if create_user_id != @user.id and ChatPost.where(room_id: room_id).count == 0
      return nil
    else
      return ret
    end
  end

   def destroy
    @user_delete = User.find(params[:id])
    @user_delete.destroy

    if @user_delete.destroy
        redirect_to '/admins/show_index', notice: "User deleted."
    end
  end

  def non_count(user_id, room_id)
    ChatPost.where.not(:user_id => user_id).where(:see => 0).where(:room_id => room_id).count
  end

  def index
    @search = User.ransack(params[:q])
    @users = @search.result
  end

  def index_admin
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

  def show
    @user = User.find(params[:id])
    @room = Room.new
    if (current_user.present?) then
      @rooms = current_user.rooms
      @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
      ids = [params[:id], current_user.id]
      @create_room = UserRoom.where(:user_id => ids).where(:to_user_id => ids).first
      @user_room_rels_count = 0
      user_room_rels = UserRoom.where(:user_id => current_user.id).or(UserRoom.where(:to_user_id => current_user.id))
      user_room_rels.find_each do | user_room_rel |
        @user_room_rels_count += ChatPost.where.not(:user_id => current_user.id).where(:see => 0).where(:room_id => user_room_rel.room_id).count
      end
    else
      @rooms = @user.rooms
      @nonrooms = Room.where(id: UserRoom.where.not(user_id: @user.id).pluck(:id))
      ids = [params[:id], @user.id]
      @create_room = UserRoom.where(:user_id => ids).where(:to_user_id => ids).first
      @user_room_rels_count = 0
      user_room_rels = UserRoom.where(:user_id => @user.id).or(UserRoom.where(:to_user_id => @user.id))
      user_room_rels.find_each do | user_room_rel |
        @user_room_rels_count += ChatPost.where.not(:user_id => @user.id).where(:see => 0).where(:room_id => user_room_rel.room_id).count
      end
    end
  end

  def show_admin
    @users = User.all
    @room = Room.new
    print @users
    # @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
    # ids = [params[:id], current_user.id]
    # @create_room = UserRoom.where(:user_id => ids).where(:to_user_id => ids).first
    # @user_room_rels_count = 0
    # user_room_rels = UserRoom.where(:user_id => current_user.id).or(UserRoom.where(:to_user_id => current_user.id))
    # user_room_rels.find_each do | user_room_rel |
    #   @user_room_rels_count += ChatPost.where.not(:user_id => current_user.id).where(:see => 0).where(:room_id => user_room_rel.room_id).count
    # end
  end

  def show_following
    @user = User.find(params[:id])
  end

  def show_follower
    @user = User.find(params[:id])
  end

  def chat_index
    # @to_users = nil
    @user = User.find(params[:id])
    room_ids = []
    room_rels = UserRoom.where(user_id: @user.id).or(UserRoom.where(to_user_id: @user.id)).find_each do | room_rel |
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
    print @rooms
  end

  def chat_index_admin
    room_ids = []
    user_ids = []
    room_rels = UserRoom.all.find_each do | room_rel |
      unless room_ids.include?(room_rel.room_id)
        room_ids.push(room_rel.room_id)
        user_ids.push(room_rel.user_id)
      end
      # if room_rel.user_id == current_user.id
      #   ids.push(room_rel.to_user_id)
      # else
      #   ids.push(room_rel.user_id)
      # end
    end
    @rooms = Room.where(:id => room_ids)
    @users_admin = User.where(:id => user_ids)
    @indexes = []
    p @indexes.fill(0, @users_admin.to_a.length) {|i| i}
    print @users_admin.to_a
    print @rooms.to_a.length
    print @users_admin.to_a[0].avater
    print @indexes
    print  "yaerafaw"
  end

  def avater_update
    param_avater = params[:item][:images_attributes][0][:image_url]
    # if params[:user] and avater = params[:user][:avater]
    #   @user = User.find(current_user.id)
    #   @user.avater.attach(avater)
    # end
    if param_avater
      @user = User.find(current_user.id)
      @user.avater.attach(param_avater)
    end
    redirect_to "/users/edit"
  end

  def bank_update
    if params[:user]
      @user = User.find(current_user.id)
      @user.update(bank_name: params[:user][:bank_name], bank_branch_name: params[:user][:bank_branch_name], bank_account_type: params[:user][:bank_account_type], bank_account_number: params[:user][:bank_account_number], bank_account_horseman_name_kana: params[:user][:bank_account_horseman_name_kana])
    end
    redirect_to "/users/edit"
  end

  def stop_isstopped
    @user = User.find(params[:id])
    @user.isstopped = true
    @user.save
    redirect_to "/admins/show_index"
  end

  def update_isstopped
    @user = User.find(params[:id])
    @user.isstopped = false
    @user.save
    redirect_to "/admins/show_index"
  end
end
