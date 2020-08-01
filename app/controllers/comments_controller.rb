class CommentsController < ApplicationController

  def new
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:id], content: params[:content])
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id) #追加
  end
end
