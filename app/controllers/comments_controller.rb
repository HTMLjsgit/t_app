class CommentsController < ApplicationController

  def new
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], content: params[:content])
    @comment.save
      redirect_to(post_path)

  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id) #追加
  end
end
