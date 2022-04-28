class TransferRequestsController < ApplicationController
  before_action :user_find
  before_action :user_admin_check
  def update
    if transfer_request_params[:transfer_mode] == "false"
      #振込をFalseにするとき 管理者のみにしておく
      if !current_user.admin
        redirect_to root_path and return
      end
    end

    @user.transfer_request.update(transfer_request_params)
    redirect_to user_sales_path(@user.id)
  end

  private

  def transfer_request_params
    params.permit(:transfer_mode)
  end

  def user_find
    @user = User.find params[:id]
  end

  def user_admin_check
    if @user.id != current_user.id && !current_user.admin
      redirect_to root_path and return
    end
  end
end
