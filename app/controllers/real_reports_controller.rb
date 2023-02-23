class RealReportsController < ApplicationController
  def create
    @real = Real.find(params[:real_id])
    body = params[:body]
    real_report = current_user.real_reports.new(real_id: @real.id, body: body)
    if real_report.save
      @already_message = "管理者に送信されました。"
    else

    end
    render "real_report.js.erb"
  end
end
