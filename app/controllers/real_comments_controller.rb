class RealCommentsController < ApplicationController
  before_action :set_real_comment, only: [:show, :edit, :update, :destroy]

  # GET /real_comments
  # GET /real_comments.json
  def index
    @real_comments = RealComment.all
  end

  # GET /real_comments/1
  # GET /real_comments/1.json
  def show
  end

  # GET /real_comments/new
  def new
    @real = Real.find(params[:id])
    @real_comment = @real.real_comments.build(user_id: current_user.id)
  end

  # POST /real_comments
  # POST /real_comments.json
  def create
    @real = Real.find(params[:real_comment][:real_id])
    @real_comment = @real.real_comments.build(real_comment_params)
    @real_comment.user_id = current_user.id

    respond_to do |format|
      if @real_comment.save
        format.html { redirect_to real_path(@real), notice: 'Real comment was successfully created.' }
        format.json { render :show, status: :created, location: @real_comment }
      else
        format.html { render :new }
        format.json { render json: @real_comment.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /real_comments/1
  # DELETE /real_comments/1.json
  def destroy
    @real_comment.destroy
    respond_to do |format|
      format.html { redirect_to real_comments_url, notice: 'Real comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_real_comment
      @real_comment = RealComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def real_comment_params
      params.require(:real_comment).permit(:comment, :user_id, :real_id)
    end
end
