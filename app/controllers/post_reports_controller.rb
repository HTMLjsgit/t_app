class PostReportsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    body = params[:body]
    current_user.post_reports.create(post_id: @post.id, body: body)
    flash[:successed_message] = "管理者に報告されました。"
    render "post_report.js.erb"
  end
end
