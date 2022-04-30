class UsersController < ApplicationController
  helper_method :non_count
  helper_method :get_to_user
  before_action :authenticate_user!, only: [:transfers, :avater_update, :bank_update]

  before_action :user_find, only: [:update, :show, :transfers]
  include CommonPaymentSettings
  before_action :payment_setting_get, only: [:show, :transfers]
  before_action :user_admin_check, only: [:transfers, :update, :bank_update, :avater_update]
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

  # def destroy
  #   @user_delete = User.find(params[:id])
  #   @user_delete.destroy

  #   if @user_delete.destroy
  #       redirect_to '/admins/show_index', notice: "User deleted."
  #   end
  # end

  def non_count(user_id, room_id)
    ChatPost.where.not(:user_id => user_id).where(:see => 0).where(:room_id => room_id).count
  end

  def index
    @search = User.ransack(params[:q])
    @users = @search.result
  end

  def show
    @room = Room.new
    gon.stripe_public_key = Rails.configuration.stripe[:public_key]
    reals_id = ImageReal.pluck(:real_id)
    @reals = @user.reals.where(id: reals_id).includes(:image_reals).distinct
    @reals_not = @user.reals.where.not(id: reals_id).includes(:image_reals).distinct
    if user_signed_in?
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
  def update
    @user.update!(user_params)
    redirect_to user_path(current_user)
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
    end
    @rooms = Room.where(:id => room_ids)
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

  def user_find
    @user = User.find params[:id]
  end
  private

  def user_params
    params.require(:user).permit(:background_image, :username, :avater)
  end

  def user_admin_check
    if current_user.id != @user.id && !current_user.admin
      redirect_to root_path and return
    end
  end


end
