class TransferCompletionsController < ApplicationController
  def update
    if !current_user.admin?
      redirect_to root_path and return
    end
    already_transfer = params[:already_transfer]
    @transfer_completion = TransferCompletion.find params[:id]
    @transfer_completion.update(already_transfer: already_transfer)
    redirect_to admin_transfer_request_path(@transfer_completion)
  end
end
