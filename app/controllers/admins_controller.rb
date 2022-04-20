class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  def index

  end

  def type_change
    @type = params[:type]

  end

  private

  def is_admin?
    unless current_user.admin
      redirect_to root_path and return
    end
  end
end
