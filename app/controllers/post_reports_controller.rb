class PostReportsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    body = params[:body]
    post_report = current_user.post_reports.new(post_id: @post.id, body: body)
    if post_report.save
      @already_message = "管理者に送信されました。"
    else

    end
    render "post_report.js.erb"
  end
end
