class ReportsController < ApplicationController
  before_action :authenticate_user!
  def create
    post_id = params[:post_id]
    body = params[:body]
    current_user.report(post_id, body)
  end
end
