class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find
  before_action :user_admin_check
  def index
    @sales = @user.sales
    @no_yet_transfer_sales = @sales.where(transfer: false)
    @yet_transfer_sales = @sales.where(transfer: true)
    # @sales_total = Sale.total()
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
