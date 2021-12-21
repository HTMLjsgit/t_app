class RealsController < ApplicationController
  def index
    @reals = Real.all
  end
end
