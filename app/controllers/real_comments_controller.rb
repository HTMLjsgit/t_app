class RealCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :set_real_comment, only: [:show, :update, :destroy]
  before_action :admin_user_check, only: [:update, :destroy]
  def create
    @real = Real.find(params[:real_id])
    @real_comment = @real.real_comments.new(real_comment_params)
    @real_comment.save
    redirect_to real_path(@real)
  end
  def update
    @real_comment.update(real_comment_params)
  end
  def destroy
    @real_comment.destroy
    redirect_to real_path(@real_comment.real)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_real_comment
      @real_comment = RealComment.find(params[:id])
    end
    def admin_user_check
      if current_user.id != @real_comment.user_id && !current_user.admin
        redirect_to root_path and return
      end
    end

    # Only allow a list of trusted parameters through.
    def real_comment_params
      params.require(:real_comment).permit(:comment, :real_id).merge(user_id: current_user.id)
    end
end
