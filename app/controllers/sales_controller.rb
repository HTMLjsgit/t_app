class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find
  before_action :user_admin_check
  def index
    @sales = @user.sales
    @total_zero = @user.transfer_total.total <= 0 ? true : false
    @transfer_requests = @user.transfer_requests.where(already_request: true).order(created_at: :desc)
  end

  private

  def user_admin_check
    if !current_user.admin? && current_user.id != @user.id
      redirect_to root_path and return
    end
  end

  def user_find
    @user = User.find params[:user_id]
  end
end
