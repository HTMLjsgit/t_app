class CommentsController < ApplicationController

  def index
    @comments = Comment.all.order(created_at: :desc)
  end

  def new
    # @post = Post.new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(user_id: current_user.id, post_id: params[:comment][:posts_id], content: params[:comment][:content])
    @comment.save!
#    redirect_to(post_path)→redirect_to(posts_path)
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id) #追加
  end
end
