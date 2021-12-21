class RealsController < ApplicationController
  def index
    @reals = Real.all.order(create_at: :desc)
  end

  def show
    @real = Real.find_by(id: params[:id])
  end

  def new
  end

  def create
    @real = Real.new(content: params[:content])
    @real.save
    redirect_to(reals_path)
  end
end
