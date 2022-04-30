class TransferRequestsController < ApplicationController
  before_action :user_find
  before_action :user_admin_check
  def create
    if @user.transfer_total.total <= 0
      redirect_to user_sales_path(user_id: @user.id) and return
    end
    ActiveRecord::Base.transaction do
      transfer_request = TransferRequest.create!(user_id: @user.id, amount: @user.transfer_total.total, already_request: true) #振込申請の作成
      TransferCompletion.create!(user_id: @user.id, transfer_request_id: transfer_request.id, already_transfer: false) #振込がされたかのレコード作成
      @user.transfer_total.update!(total: 0) #振込申請されたら振込申請可能額を0にする。(Reset!)
    end
    redirect_to user_sales_path(user_id: @user.id)
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
