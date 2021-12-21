class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def new
    # @post = Post.new
    @posts_id = params[:posts_id]
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:comment][:posts_id], content: params[:comment][:content])
    @comment.save
#    redirect_to(post_path)→redirect_to(posts_path)
    redirect_to "/posts/"+params[:comment][:posts_id]
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id) #追加
  end
end
