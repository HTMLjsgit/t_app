class UsersController < ApplicationController
  helper_method :non_count
  helper_method :get_to_user
  before_action :authenticate_user!, only: [:transfers, :avater_update, :bank_update]

  before_action :user_find, only: [:update, :show, :transfers, :bank_update, :avater_update]
  include CommonPaymentSettings
  before_action :payment_setting_get, only: [:show, :transfers]
  before_action :user_admin_check, only: [:transfers, :update, :bank_update, :avater_update]

  # def destroy
  #   @user_delete = User.find(params[:id])
  #   @user_delete.destroy

  #   if @user_delete.destroy
  #       redirect_to '/admins/show_index', notice: "User deleted."
  #   end
  # end

  def index
  end

  def show
    @room = Room.new
    gon.stripe_public_key = Rails.configuration.stripe[:public_key]
    @reals = @user.reals.includes(:image_reals).distinct
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
      @user.update(bank_name: params[:user][:bank_name], bank_branch_name: params[:user][:bank_branch_name], bank_account_type: params[:user][:bank_account_type], bank_account_number: params[:user][:bank_account_number], bank_account_horseman_name_kana: params[:user][:bank_account_horseman_name_kana])
    end
    redirect_to "/users/edit"
  end

  def user_find
    @user = User.find params[:id]
  end
  private

  def user_params
    params.require(:user).permit(:background_image, :username, :avater, :introduction)
  end

  def user_admin_check
    if current_user.id != @user.id && !current_user.admin
      redirect_to root_path and return
    end
  end


end
